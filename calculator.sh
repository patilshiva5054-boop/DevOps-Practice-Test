#!/bin/bash
# Simple calculator script

# Ask for first number
read -p "Enter first number: " num1

# Ask for operator
read -p "Enter operator (+, -, *): " op

# Ask for second number
read -p "Enter second number: " num2

# Perform calculation
if [ "$op" == "+" ]; then
    result=$((num1 + num2))
elif [ "$op" == "-" ]; then
    result=$((num1 - num2))
elif [ "$op" == "*" ]; then
    result=$((num1 * num2))
else
    echo "Invalid operator!"
    exit 1
fi

# Show result
echo "Result: $result"



elif [ "$op" == "/" ]; then
    result=$((num1 / num2))
