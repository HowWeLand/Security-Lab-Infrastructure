#!/bin/bash
# Remove all packages from a tag, even if apt thinks they're needed elsewhere

TAG="$1"

if [ -z "$TAG" ]; then
    echo "Usage: nuclear-cleanup.sh <tag>"
    exit 1
fi

echo "🧨 NUCLEAR CLEANUP FOR TAG: $TAG"
echo "================================="

# Show what we're about to remove
echo "Packages to be removed:"
aptitude search "?user-tag($TAG)?~i" --display-format "%p"

read -p "Continue? (y/N): " confirm
if [ "$confirm" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Remove each package individually (bypasses some dependency checks)
aptitude search "?user-tag($TAG)?~i" --display-format "%p" | while read pkg; do
    echo "Removing: $pkg"
    sudo apt remove --purge "$pkg"
done

sudo apt autoremove
