#!/bin/bash
# Comment me later
echo "💥 JAVASCRIPT PACKAGE MANAGER CIVIL WAR"
echo "========================================"

echo ""
echo "📦 PACKAGE MANAGER CENSUS:"
echo "npm: $(aptitude search '?user-tag(npm-transitive-deps)' | wc -l) transitive dependencies"
echo "yarn: $(aptitude search '?user-tag(yarn-transitive-deps)' | wc -l) transitive dependencies" 
echo "pnpm: $(aptitude search '?user-tag(pnpm-transitive-deps)' | wc -l) transitive dependencies"

echo ""
echo "🤯 DUPLICATE DEPENDENCIES (because why not):"
# Find packages that got installed multiple times for different managers
aptitude search '?user-tag(npm-transitive-deps)?user-tag(yarn-transitive-deps)'
aptitude search '?user-tag(npm-transitive-deps)?user-tag(pnpm-transitive-deps)'

echo ""
echo "🎯 THE ACTUAL TOOLS (buried under dependency hell):"
aptitude search '?user-tag(js-package-managers)'
