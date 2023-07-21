#!/bin/bash

# Function to increment the semantic version
increment_semantic_version() {
    # Extract major, minor, and patch from the provided version
    local major=$(echo "$1" | cut -d'.' -f1 | sed 's/v//')
    local minor=$(echo "$1" | cut -d'.' -f2)
    local patch=$(echo "$1" | cut -d'.' -f3)

    if [ "$major" -lt 50 ] && [ "$minor" -lt 50 ] && [ "$patch" -lt 50 ]; then
        # Increment the patch version
        ((patch++))
    elif [ "$major" -lt 50 ] && [ "$minor" -lt 50 ] && [ "$patch" -eq 50 ]; then
        # Increment the minor version and reset patch
        ((minor++))
        patch=0
    elif [ "$major" -lt 50 ] && [ "$minor" -eq 50 ] && [ "$patch" -eq 50 ]; then
        # Increment the major version and reset minor and patch
        ((major++))
        minor=0
        patch=0
    else
        # Limit reached, set to the maximum allowed version
        major=50
        minor=50
        patch=50
    fi

    # Format the new version and return
    echo "v${major}.${minor}.${patch}"
}

# Example usage:
current_version="v0.50.50"
incremented_version=$(increment_semantic_version "$current_version")
echo "Current version: $current_version"
echo "Incremented version: $incremented_version"
