local lastNotificationTime = nil

-- Function to handle notifications
local function ShowNotification(title, text, type)
    local currentTime = GetGameTimer()
    if not lastNotificationTime or (currentTime - lastNotificationTime > Config.NotificationCooldown) then
        if Config.Notify == 'ox' then
            lib.notify({
                title = title,
                description = text,
                type = type
            })
        elseif Config.Notify == 'esx' then
            ESX.ShowNotification(text)
        elseif Config.Notify == 'custom' and Config.CustomNotify then
            Config.CustomNotify(source, text)
        elseif Config.Notify == 'print' then
            print(text)
        elseif Config.Notify == 'none' then
            -- No notification
        end
        lastNotificationTime = currentTime
    end
end

-- Function to translate a position in the direction of a given heading
local function TranslateVector3(pos, angle, distance)
    local angleRad = angle * 2.0 * math.pi / 360.0
    return vector3(pos.x - distance * math.sin(angleRad), pos.y + distance * math.cos(angleRad), pos.z)
end

-- Traffic Light Control Logic
CreateThread(function()
    while true do
        local ped = cache.ped
        local vehicle = cache.vehicle
        local siren = vehicle and IsVehicleSirenOn(vehicle)

        if vehicle and siren then
            local playerPosition = GetEntityCoords(ped)
            local playerHeading = GetEntityHeading(ped)
            local trafficLight = 0

            for searchDistance = Config.SEARCH_MAX_DISTANCE, Config.SEARCH_MIN_DISTANCE, -Config.SEARCH_STEP_SIZE do
                Wait(Config.TRAFFIC_LIGHT_POLL_FREQUENCY_MS)

                local searchPosition = TranslateVector3(playerPosition, playerHeading, searchDistance)

                for _, trafficLightObject in pairs(Config.TrafficLightObjects) do
                    trafficLight = GetClosestObjectOfType(searchPosition, Config.SEARCH_RADIUS, trafficLightObject, false, false, false)

                    if trafficLight ~= 0 then
                        local lightHeading = GetEntityHeading(trafficLight)
                        local headingDiff = math.abs(playerHeading - lightHeading)

                        if headingDiff < Config.HEADING_THRESHOLD or headingDiff > (360.0 - Config.HEADING_THRESHOLD) then
                            -- Sync the traffic light state with the server (set green)
                            TriggerServerEvent('trafficlights:syncTrafficLight', trafficLight, true)
                            SetEntityTrafficlightOverride(trafficLight, 0)  -- Set light to green
                            ShowNotification("Traffic Lights", "Traffic light set to green.", "success")

                            -- Set a timeout to change back to red
                            SetTimeout(Config.TRAFFIC_LIGHT_GREEN_DURATION_MS, function()
                                SetEntityTrafficlightOverride(trafficLight, -1)  -- Reset light to red
                                ShowNotification("Traffic Lights", "Traffic light reset.", "inform")
                            end)
                            break
                        else
                            trafficLight = 0
                        end
                    end
                end

                -- Adjust polling frequency based on proximity to traffic lights
                if trafficLight ~= 0 then
                    local normalizedDistance = (searchDistance - Config.SEARCH_MIN_DISTANCE) / (Config.SEARCH_MAX_DISTANCE - Config.SEARCH_MIN_DISTANCE)
                    Config.TRAFFIC_LIGHT_POLL_FREQUENCY_MS = math.max(50, math.floor(Config.TRAFFIC_LIGHT_POLL_FREQUENCY_MS - normalizedDistance * (Config.TRAFFIC_LIGHT_POLL_FREQUENCY_MS - 50)))
                    break
                end
            end
        else
            Wait(1000)  -- If no siren or vehicle detected, slow down polling
        end
    end
end)

-- Listen for updates from the server on traffic light state
RegisterNetEvent('trafficlights:updateTrafficLight')
AddEventHandler('trafficlights:updateTrafficLight', function(trafficLight, isGreen)
    -- Store or update the traffic light state in local memory
    if isGreen then
        SetEntityTrafficlightOverride(trafficLight, 0)  -- Green light
    else
        SetEntityTrafficlightOverride(trafficLight, -1)  -- Red light
    end
end)

-- Listen for notifications about traffic light state changes
RegisterNetEvent('trafficlights:notifyStateChange')
AddEventHandler('trafficlights:notifyStateChange', function(trafficLight, isGreen)
    -- Display notification when state changes
    local status = isGreen and "Green" or "Red"
    ShowNotification("Traffic Light Change", "Traffic light is now " .. status, "info")
end)
