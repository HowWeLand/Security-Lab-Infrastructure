## Apt Aliases (Package Management)

### Philosophy

"Track why you install things, or suffer trying to remember later"

The `apt-tag` system uses aptitude's user tagging to maintain semantic
relationships between packages. When you install something, you tag it
with WHY you installed it.

### Usage Examples
```bash
# Install package with dependencies, tag all
apt-tag ripgrep fd-find bat
# All three tagged as "ripgrep"

# Later, find everything related to ripgrep
tag-search ripgrep

# Remove ripgrep, find orphaned dependencies
sudo apt remove ripgrep
tag-orphans  # Shows: fd-find, bat

# Tag existing packages
retag development vim neovim helix

# Batch tag from file
echo "nmap\nwireshark\nburpsuite" > security-tools.txt
tag-from-file security:pentest security-tools.txt
