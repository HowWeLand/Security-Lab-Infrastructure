#!/bin/bash
# a POC on how the tag system could be used to clean up
echo "🔥 JAVASCRIPT DEPENDENCY HOLOCAUST"
echo "=================================="

echo ""
echo "📊 DEPENDENCY CENSUS:"
# Where the magic happens by echoing the output of these commands, We can really se what a
# mess we've got on our hands
echo "String manipulation: $(aptitude search '?user-tag(js-string-deps)' | wc -l) packages"
echo "File system madness: $(aptitude search '?user-tag(js-fs-deps)' | wc -l) packages" 
echo "Utility nonsense: $(aptitude search '?user-tag(js-util-deps)' | wc -l) packages"
echo "Testing bloat: $(aptitude search '?user-tag(js-test-deps)' | wc -l) packages"

# Anything whose parent rdepend tag is not installed and was not intensional installed
echo ""
echo "💀 ORPHANED JS PACKAGES (safe to remove):"
aptitude search '?user-tag(js-)?not(~g~i)?not(?user-tag(js-intentional))' --display-format "%p %T"

# Stuff you really should keep
echo ""
echo "🎯 INTENTIONAL INSTALLS (keep these):"
aptitude search '?user-tag(js-intentional)'
