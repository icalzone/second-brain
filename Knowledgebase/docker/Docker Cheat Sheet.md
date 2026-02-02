# Docker CLI Cheat Sheet

## 1\. Check Running Containers

First, list all containers to identify the one you want to modify:

`docker ps -a`

## 2\. Inspect the Restart Policy

Check the current restart policy for your container:

`docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>`

## 3\. Update the Restart Policy

Disable auto-start by updating the restart policy to `no`:

`docker update --restart=no <container_name_or_id>`

## 4\. Confirm Changes

Verify the updated restart policy:

`docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>`

## 5\. Reboot and Test

Restart your computer and confirm that the container no longer starts automatically:

`docker ps`

## Re-Enabling Auto-Start (Optional)

If you ever need the container to auto-start again, you can use:

`docker update --restart=always <container_name_or_id>`

With these steps, you have full control over which containers start automatically on your machine.