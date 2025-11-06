#!/bin/bash
# Script to greet multiple people until user types "done"

while true
do
    # Ask for a name
    read -p "Enter a name (or type 'done' to stop): " name

    # If user types 'done', break the loop
    if [ "$name" == "done" ]; then
        echo "Goodbye!"
        break
    fi

    # Otherwise, greet the person
    echo "Hello, $name!"
done
