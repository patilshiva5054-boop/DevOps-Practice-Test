#!/bin/bash
# Script to convert Celsius to Fahrenheit

# Ask user for temperature in Celsius
read -p "Enter temperature in Celsius: " celsius

# Convert Celsius to Fahrenheit using the formula F = C * 9/5 + 32
fahrenheit=$(echo "scale=2; ($celsius * 9/5) + 32" | bc)

# Display the result
echo "$celsius°C = $fahrenheit°F"
