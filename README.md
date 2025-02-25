# 🛑 CodeX Opticom 🚦  
![CodeX Opticom](https://github.com/5M-CodeX/codex-opticom/assets/112611821/f309030c-8951-4ce2-8d18-079b4508b02a)  

A Lua script for controlling traffic lights in a game environment. It enables dynamic interaction with traffic lights, allowing them to turn green under specific conditions and automatically reset to red after a set duration.  

## ✨ Features  
✔️ Automatically detects nearby traffic lights.  
✔️ Turns traffic lights green when conditions are met.  
✔️ Resets traffic lights to red after a configurable duration.  
✔️ Displays visual notifications for state changes.  

## 🔧 Configuration  

You can fine-tune the script by adjusting the following parameters:  

| Parameter | Description |
|-----------|------------|
| `SEARCH_STEP_SIZE` | Step size for scanning traffic lights. |
| `SEARCH_MIN_DISTANCE` | Minimum detection distance. |
| `SEARCH_MAX_DISTANCE` | Maximum detection distance. |
| `SEARCH_RADIUS` | Search radius after coordinate translation. |
| `HEADING_THRESHOLD` | Orientation threshold (in degrees). |
| `TRAFFIC_LIGHT_POLL_FREQUENCY_MS` | Polling frequency (in ms) for faster detection. |
| `TRAFFIC_LIGHT_GREEN_DURATION_MS` | Time (in ms) the light stays green. |

## 🚀 Usage  

1️⃣ Install the script in your game environment.  
2️⃣ Modify the parameters in the script to fit your needs.  
3️⃣ Run the script and control traffic lights dynamically.  

## 🔔 Notifications  

The script provides on-screen messages for traffic light changes:  

🟢 **"Traffic light set to green."** – Light turns green.  
🔴 **"Traffic light reset."** – Light turns red.  

## 📜 License  

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details. 

⚠ Note: The original creator, [TheStoicBear](https://github.com/TheStoicBear), has chosen to change the license of his current repository to a more restrictive one that requires explicit permission for any modifications.
I strongly oppose this approach and believe that open-source software should remain freely available under licenses that encourage collaboration and unrestricted public use.