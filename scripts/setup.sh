#!/usr/bin/env sh

set -e

echo "Setting up second brain folder structure..."

mkdir raw
mkdir wiki
mkdir wiki/concepts
mkdir wiki/projects
mkdir wiki/systems
mkdir wiki/people
mkdir wiki/sources
mkdir outputs
mkdir outputs/queries
mkdir outputs/briefs
mkdir outputs/reports
mkdir meta
mkdir .vscode

echo "✅ Folder structure created."
echo "You can now open this repo in VS Code."