#!/bin/bash
#
# `init.sh`
# A Script to prepare and launch folders and configuration files for use with LiveSync Subscriber publisher.
# 2023 vorotamoroz; Licensed as MIT.
#
cd /app
# Create a folder to store files that should be made persistent.1
mkdir -p content
mkdir -p content/sitesrc
mkdir -p content/content
# Hugo toml modification
echo baseURL = "'${LSSP_HUGO_BASEURL}'" > hugosite/hugo.toml
echo languageCode = "'${LSSP_HUGO_LANGUAGE}'" >> hugosite/hugo.toml
echo title = "'${LSSP_HUGO_TITLE}'" >> hugosite/hugo.toml
cat hugo.template.toml >> hugosite/hugo.toml
./build.sh
# Subscriber initialisation
cd subscriber
## Generate config from environment variables
deno run -A genconf.ts
deno run -A main.ts
