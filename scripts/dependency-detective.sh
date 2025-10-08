#!/bin/bash
# Find packages that lost their parent but still have the tags

TARGET_TAG="$1"  # e.g. "neovim"

echo "🔍 Forensic analysis for tag: $TARGET_TAG"
echo "=========================================="

# Get all packages with the tag
TAGGED_PKGS=$(aptitude search "?user-tag($TARGET_TAG)" --display-format "%p" | sort)

# Get currently installed packages  
INSTALLED_PKGS=$(dpkg -l | grep '^ii' | awk '{print $2}' | sort)

# Find tagged packages that are still installed
echo ""
echo "🧩 ORPHANED DEPENDENCIES STILL INSTALLED:"
comm -12 <(echo "$TAGGED_PKGS") <(echo "$INSTALLED_PKGS")

# Show what was properly cleaned up
echo ""
echo "✅ PROPERLY REMOVED:"
comm -23 <(echo "$TAGGED_PKGS") <(echo "$INSTALLED_PKGS")
