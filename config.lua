Config = {}

-------------------
-- Notifications --
-------------------
Config.Notify = 'ox'  -- Options: 'esx', 'ox', 'custom', 'print', 'none'

Config.NotificationCooldown = 5000  -- Cooldown time (ms) between notifications

-- Custom Notification Function (if using 'custom' Notify)
Config.CustomNotify = function(source, message)
    TriggerClientEvent('NOTIFY_NAME', source, message) -- Replace NOTIFY_NAME with your notification event
end

-------------
-- Updates --
-------------
Config.Update = true  -- Set to false if you don't want to use the update system

------------------
-- Translations --
------------------
Config.NoLicenses = 'You have no licenses.'

-------------------------
-- Traffic Light Stuff --
-------------------------
Config.TrafficLightObjects = {
    0x3E2B73A4, -- prop_traffic_01a
    0x336E5E2A, -- prop_traffic_01b
    0xD8EBA922, -- prop_traffic_01d
    0xD4729F50, -- prop_traffic_02a
    0x272244B2, -- prop_traffic_02b
    0x33986EAE, -- prop_traffic_03a
    0x2323CDC5  -- prop_traffic_03b
}

-----------------------------------
-- Traffic Light Search Settings --
-----------------------------------
Config.SEARCH_STEP_SIZE = 10.0
Config.SEARCH_MIN_DISTANCE = 5.0
Config.SEARCH_MAX_DISTANCE = 30.0
Config.SEARCH_RADIUS = 20.0
Config.HEADING_THRESHOLD = 40.0

----------------------
-- Polling & Timing --
----------------------
Config.TRAFFIC_LIGHT_POLL_FREQUENCY_MS = 50
Config.TRAFFIC_LIGHT_GREEN_DURATION_MS = 5000