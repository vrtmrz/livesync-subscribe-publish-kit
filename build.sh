#!/bin/sh
#
# `build.sh`
# A Script to export Obsidian vaults while converting them to standard Markdown for rendering in Hugo.
# 2023 vorotamoroz; Licensed as MIT.
#
/root/.cargo/bin/obsidian-export --no-git /app/content/sitesrc /app/content/content
grep "share: true" -Lir /app/content/content | grep -E "\.md$" | awk '{print "\"" $0 "\""}' | xargs rm -fv
cd /app/hugosite
../hugo