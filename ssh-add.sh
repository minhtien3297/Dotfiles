#!/bin/bash

# Define the file parameter
file="$1"

# Add the specified private key to the SSH agent
ssh-add "$file"

