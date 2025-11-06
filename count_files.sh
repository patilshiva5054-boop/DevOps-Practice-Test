#!/bin/bash
# Script to count number of files in current directory

# Use ls and wc command
count=$(ls -1 | wc -l)

echo "There are $count files in the current directory."
