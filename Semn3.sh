#!/bin/bash

# Function to increment the semantic version
increment_semantic_version() {
    # Extract major, minor, and patch from the provided version
    local major=$(echo "$1" | cut -d'.' -f1 | sed 's/v//')
    local minor=$(echo "$1" | cut -d'.' -f2)
    local patch=$(echo "$1" | cut -d'.' -f3)

    # Handle cases where version part is not provided
    major=${major:-0}
    minor=${minor:-0}
    patch=${patch:-0}

    # Validate version parts and ensure they are within the specified range
    if [ "$major" -gt 50 ] || [ "$minor" -gt 50 ] || [ "$patch" -gt 50 ]; then
        echo "Error: Invalid version format. Version parts should be less than or equal to 50."
        exit 1
    fi

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
    elif [ "$major" -eq 50 ] && [ "$minor" -eq 50 ] && [ "$patch" -eq 50 ]; then
        # Limit reached, set to the maximum allowed version
        major=50
        minor=50
        patch=50
    fi

    # Format the new version and return
    echo "v${major}.${minor}.${patch}"
}

# Example usage:
current_version="v50.0.50"
incremented_version=$(increment_semantic_version "$current_version")
echo "Current version: $current_version"
echo "Incremented version: $incremented_version"
