#!/bin/bash
echo "🕵️ CROSS-REFERENCE AUDIT"
echo "========================"

# What packages have editor tags but no editor installed?
echo "Editor-related packages without editors:"
{ aptitude search '?user-tag(neovim)?~i'
  aptitude search '?user-tag(vim)?~i' 
  aptitude search '?user-tag(emacs)?~i'
} | while read pkg; do
    # Check if any actual editors are installed
    if ! dpkg -l | grep -q -E "(neovim|vim|emacs|nano)"; then
        echo "ORPHANED: $pkg"
    fi
done

# Find packages that serve no purpose anymore
echo ""
echo "🏷️  TAGS WITHOUT THEIR PARENTS:"
for tag in neovim-deps vim-plugins emacs-packages; do
    if aptitude search "?user-tag($tag)?~i" | grep -q .; then
        echo "Tag '$tag' has packages but no parent tool"
        aptitude search "?user-tag($tag)?~i" --display-format "  %p"
    fi
done
