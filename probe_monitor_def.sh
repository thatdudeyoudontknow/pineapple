#!/bin/bash

# Continuously monitor probe requests and display the strongest last 10 in real-time

# Function to extract SSID and signal strength from probe request logs
extract_ssid_strength() {
    grep "Probe Request" /pineapple/logs/pineap.log | awk '{print $NF "," $(NF-2)}'
}

# Main loop to continuously update and display the strongest networks
while true; do
    # Extract SSIDs and signal strengths
    ssid_strength=$(extract_ssid_strength)
    
    # Sort SSIDs based on signal strength (dBm)
    sorted_output=$(echo "$ssid_strength" | sort -t ',' -k 2 -n -r)

    # Display the top 10 strongest networks
    clear
    echo "Top 10 Strongest Wi-Fi Networks (SSID, Signal Strength)"
    echo "-------------------------------------------------------"
    echo "$sorted_output" | head -n 10

    # Wait for a few seconds before updating the display
    sleep 5
done
