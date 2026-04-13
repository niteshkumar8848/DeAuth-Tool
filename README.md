# DeAuth Tool

## Overview
DeAuth Tool is a Bash script designed for **educational and authorized testing purposes only**. It performs WiFi deauthentication (DeAuth) attacks using the Aircrack-ng suite. This tool automates the process of:

- Listing wireless interfaces
- Killing conflicting processes
- Putting the interface into monitor mode
- Scanning for nearby networks
- Locking to a target network's channel
- Sending deauthentication packets to disconnect devices from the target access point (AP)

**⚠️ Legal and Ethical Warning**: 
- DeAuth attacks can disrupt network services and may be illegal in your jurisdiction without explicit permission.
- Use **only** on networks you own or have written authorization to test.
- The author and this tool are not responsible for misuse.

## Features
- Interactive interface and network selection
- Automatic monitor mode setup and teardown
- Network scanning with airodump-ng
- Channel locking for stability
- Configurable deauth packet count
- Broadcast deauth (all clients) support
- Automatic NetworkManager restart on exit

## Requirements
- Linux OS (tested on Ubuntu/Debian with kernel supporting wireless monitor mode)
- Root privileges (`sudo`)
- A compatible wireless adapter supporting monitor mode (e.g., Atheros AR9271, Ralink RT3070; check with `iwconfig`)
- Aircrack-ng suite installed

### Installation
1. Update your system:
   ```
   sudo apt update && sudo apt upgrade -y
   ```
2. Install Aircrack-ng:
   ```
   sudo apt install aircrack-ng -y
   ```
3. Verify wireless support:
   ```
   iwconfig
   sudo airmon-ng check kill
   ```
4. Make the script executable:
   ```
   chmod +x DeAuth.sh
   ```

## Usage
1. Run the script with sudo:
   ```
   sudo ./DeAuth.sh
   ```
2. Follow the interactive prompts:
   - Select your wireless interface (e.g., `wlan0` or `wlp2s0`)
   - The script will switch to monitor mode (e.g., `wlan0mon`)
   - Scan and select target BSSID and channel
   - Enter number of deauth packets
3. To stop: Press `Ctrl+C`
4. Monitor mode is automatically cleaned up, and NetworkManager is restarted.

### Example Output
```
Available wireless interfaces:
wlan0     IEEE 802.11  ESSID:off/any
...

Enter the wireless interface you want to use (e.g., wlan0): wlan0

Switching to Monitor mode on interface wlan0...
New monitor interface: wlan0mon

Scanning for available wireless networks...
[airodump-ng output]

Enter the BSSID of the target network: AA:BB:CC:DD:EE:FF
Enter the channel of the target network: 6
Enter the number of deauthentication packets to send (e.g., 100): 100

DeAuth Attack has been started !!!
To exit/Stop Attack press (ctrl+c)
[aireplay-ng output]

Attack Stopped
Exiting from the Monitor mode
DeAuth Attack Completed
```

## Troubleshooting
- **No monitor mode**: Ensure your WiFi adapter supports it (`sudo airmon-ng start wlan0` manually).
- **Permission errors**: Run with `sudo`.
- **Interface not found**: Use `iwconfig` or `iw dev` to check names.
- **MT7921 chipset issues**: Script has fallback detection (commented).
- **NetworkManager conflicts**: Script kills processes and restarts service.

## Files
- `DeAuth.sh`: Main executable script
- `RoughWork.txt`: Development notes and command references

## Development Notes
This tool was developed iteratively, with fixes for channel locking, monitor interface detection, and cleanup. See `RoughWork.txt` for raw command explorations.

## License
No formal license—use at your own risk for educational purposes.

## Author
Built with ❤️ for WiFi security testing (not actual production use).

