local SEARCH_STEP_SIZE = 10.0
local SEARCH_MIN_DISTANCE = 5.0
local SEARCH_MAX_DISTANCE = 30.0
local SEARCH_RADIUS = 20.0
local HEADING_THRESHOLD = 40.0
local TRAFFIC_LIGHT_POLL_FREQUENCY_MS = 50
local TRAFFIC_LIGHT_GREEN_DURATION_MS = 5000
local lastNotificationTime = nil

local function ShowNotification(title, text, type)
    local currentTime = GetGameTimer()
    if not lastNotificationTime or (currentTime - lastNotificationTime > config["Notification Cooldown"]) then
        lib.notify({
            title = title,
            description = text,
            type = type
        })
        lastNotificationTime = currentTime
    end
end

local function TranslateVector3(pos, angle, distance)
    local angleRad = angle * 2.0 * math.pi / 360.0
    return vector3(pos.x - distance * math.sin(angleRad), pos.y + distance * math.cos(angleRad), pos.z)
end

CreateThread(function()
    while true do
        local ped = cache.ped
        local vehicle = cache.vehicle
        local siren = IsVehicleSirenOn(vehicle)
        if vehicle and siren then
            local playerPosition = GetEntityCoords(ped)
            local playerHeading = GetEntityHeading(ped)
            local trafficLight = 0

            for searchDistance = SEARCH_MAX_DISTANCE, SEARCH_MIN_DISTANCE, -SEARCH_STEP_SIZE do
                Wait(TRAFFIC_LIGHT_POLL_FREQUENCY_MS)

                local searchPosition = TranslateVector3(playerPosition, playerHeading, searchDistance)

                for _, trafficLightObject in pairs(config["Traffic Light Objects"]) do
                    trafficLight = GetClosestObjectOfType(searchPosition, SEARCH_RADIUS, trafficLightObject, false, false, false)

                    if trafficLight ~= 0 then
                        local lightHeading = GetEntityHeading(trafficLight)
                        local headingDiff = math.abs(playerHeading - lightHeading)

                        if headingDiff < HEADING_THRESHOLD or headingDiff > (360.0 - HEADING_THRESHOLD) then
                            TriggerServerEvent('trafficlights:syncTrafficLight', trafficLight, true)
                            SetEntityTrafficlightOverride(trafficLight, 0)
                            ShowNotification("Traffic Lights", "Traffic light set to green.", "success")
                            SetTimeout(TRAFFIC_LIGHT_GREEN_DURATION_MS, function()
                                SetEntityTrafficlightOverride(trafficLight, -1)
                                ShowNotification("Traffic Lights", "Traffic light reset.", "inform")
                            end)
                            break
                        else
                            trafficLight = 0
                        end
                    end
                end

                if trafficLight ~= 0 then
                    local normalizedDistance = (searchDistance - SEARCH_MIN_DISTANCE) / (SEARCH_MAX_DISTANCE - SEARCH_MIN_DISTANCE)
                    TRAFFIC_LIGHT_POLL_FREQUENCY_MS = math.max(50, math.floor(TRAFFIC_LIGHT_POLL_FREQUENCY_MS - normalizedDistance * (TRAFFIC_LIGHT_POLL_FREQUENCY_MS - 50)))
                    break
                end
            end
        else
            Wait(1000)
        end
    end
end)