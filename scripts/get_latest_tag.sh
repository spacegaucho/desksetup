#!/bin/bash
# made by Grok 3

# Script to get the latest tag from a remote Git repository

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git first."
    exit 1
fi

# Default remote name (can be overridden with argument)
REMOTE="origin"

# Check if repository URL is provided as argument
if [ $# -eq 1 ]; then
    REPO_URL="$1"
else
    # If no argument, assume we're in a git repository
    if [ ! -d .git ]; then
        echo "Error: Please provide a repository URL or run from within a git repository"
        echo "Usage: $0 [repository_url]"
        exit 1
    fi
fi

# Function to get latest tag
get_latest_tag() {
    # If repository URL is provided, fetch tags without cloning
    if [ -n "$REPO_URL" ]; then
        # Use ls-remote to get tags and sort them
        git ls-remote --tags --refs "$REPO_URL" | \
            awk '{print $2}' | \
            sed 's/refs\/tags\///' | \
            sort -V | \
            tail -n1
    else
        # If in a git repository, fetch and get latest tag
        git fetch "$REMOTE" --tags &> /dev/null
        git describe --tags "$(git rev-list --tags --max-count=1)"
    fi
}

# Get the latest tag
LATEST_TAG=$(get_latest_tag)

if [ -z "$LATEST_TAG" ]; then
    echo "Error: Could not determine latest tag"
    exit 1
else
    echo "$LATEST_TAG"
fi

exit 0
