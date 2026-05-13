Write-Output "Setting up second brain folder structure..."

New-Item -ItemType Directory -Force raw
New-Item -ItemType Directory -Force wiki
New-Item -ItemType Directory -Force wiki\concepts
New-Item -ItemType Directory -Force wiki\projects
New-Item -ItemType Directory -Force wiki\systems
New-Item -ItemType Directory -Force wiki\people
New-Item -ItemType Directory -Force wiki\sources
New-Item -ItemType Directory -Force outputs
New-Item -ItemType Directory -Force outputs\queries
New-Item -ItemType Directory -Force outputs\briefs
New-Item -ItemType Directory -Force outputs\reports
New-Item -ItemType Directory -Force meta
New-Item -ItemType Directory -Force .vscode

Write-Output "✅ Folder structure created."
Write-Output "You can now open this repo in VS Code."