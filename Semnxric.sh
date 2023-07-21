#!/bin/bash

# Function to increment the semantic version
increment_semantic_version() {
    local version="$1"

    # Check if the input version is in the correct format
    if ! [[ "$version" =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
        echo "Invalid version format. Please use the format 'vX.Y.Z' (e.g., v1.2.3)."
        exit 1
    fi

    # Extract major, minor, and patch from the provided version
    local major="${BASH_REMATCH[1]}"
    local minor="${BASH_REMATCH[2]}"
    local patch="${BASH_REMATCH[3]}"

    # Increment the version
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
