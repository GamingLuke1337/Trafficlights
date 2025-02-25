# GamingLuke´s Trafficlights

This Lua script is designed for controlling traffic lights in FiveM. It allows you to interact with traffic lights, change them to green, and automatically reset them to red after a specified duration.

## Features

- Automatically detects nearby traffic lights.
- Sets traffic lights to green when specific conditions are met.
- Resets traffic lights to red after a customizable duration.
- Provides visual notifications for traffic light state changes.
- Fully configurable notification system with support for multiple frameworks (ESX, Ox, custom, and more).

## Parameters

You can customize the script's behavior by adjusting the following parameters in the script:

- `SEARCH_STEP_SIZE`: Step size to search for traffic lights.
- `SEARCH_MIN_DISTANCE`: Minimum distance to search for traffic lights.
- `SEARCH_MAX_DISTANCE`: Maximum distance to search for traffic lights.
- `SEARCH_RADIUS`: Radius to search for traffic lights after translating coordinates.
- `HEADING_THRESHOLD`: Player must match traffic light orientation within this threshold (degrees).
- `TRAFFIC_LIGHT_POLL_FREQUENCY_MS`: Polling frequency (ms) for quicker detection.
- `TRAFFIC_LIGHT_GREEN_DURATION_MS`: Duration to keep the traffic light green (ms).
- `NotificationCooldown`: Time (in ms) between notifications.

## Notifications System

- **'ox'**: Uses `lib.notify()` for notifications.
- **'esx'**: Uses `ESX.ShowNotification()` for notifications.
- **'custom'**: Use your own notification function, defined in the config.lua
- **'print'**: Outputs the message to the console.
- **'none'**: No notifications are shown.

## Changelog

### [v1.1.0] - 25.02.2025
- **Notification System Enhancement**: Added support for multiple notification systems (`ox`, `esx`, `custom`, `print`, `none`).
  - Notifications are now controlled via `Config.Notify` and can be customized further using `Config.CustomNotify` for custom systems.
- **Code Cleanup**: Refactored code to improve readability and modularity

## Notifications

The script provides on-screen messages for traffic light changes:

🟢 "Traffic light set to green." – Light turns green.
🔴 "Traffic light reset." – Light turns red.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

⚠ Note: The original creator, [TheStoicBear](https://github.com/TheStoicBear), has chosen to change the license of his current repository to a more restrictive one that requires explicit permission for any modifications.
I strongly oppose this approach and believe that open-source software should remain freely available under licenses that encourage collaboration and unrestricted public use.