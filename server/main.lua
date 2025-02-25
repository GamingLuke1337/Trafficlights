local trafficLightStates = {}

RegisterServerEvent('trafficlights:syncTrafficLight')
AddEventHandler('trafficlights:syncTrafficLight', function(trafficLight, isGreen)
    local src = source
    local playerName = GetPlayerName(src)

    trafficLightStates[trafficLight] = isGreen

    TriggerClientEvent('trafficlights:updateTrafficLight', -1, trafficLight, isGreen)

    TriggerClientEvent('trafficlights:notifyStateChange', src, trafficLight, isGreen)
end)

AddEventHandler('playerConnecting', function()
    local playerId = source
    local playerName = GetPlayerName(playerId)

    for _, trafficLight in pairs(Config.TrafficLightObjects) do
        local state = trafficLightStates[trafficLight] or false
        TriggerClientEvent('trafficlights:updateTrafficLight', playerId, trafficLight, state)
    end
end)

function GetTrafficLightState(trafficLight)
    return trafficLightStates[trafficLight] or false 
