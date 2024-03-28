#!/bin/bash

# Function to capture probe requests and display the last 10 found
capture_probe_requests() {
    # Run airodump-ng in the background to continuously scan for probe requests
    airodump-ng wlan0mon --output-format csv --write probe_requests.csv >/dev/null 2>&1 &

    # Continuously process the output of airodump-ng
    while true; do
        # Extract the last 10 probe requests from the CSV file
        tail -n 10 probe_requests.csv | awk -F',' '{print "SSID:", $14, "MAC:", $13, "Frequency:", $5, "Signal Strength:", $8 "dBm"}'

        # Wait for a few seconds before updating the display
        sleep 5
    done
}

# Run the function to capture probe requests and display the last 10 found
capture_probe_requests
