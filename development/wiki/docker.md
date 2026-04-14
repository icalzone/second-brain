# Docker

A quick reference for Docker CLI commands, container management, and restart policy configuration.

## Essential CLI Commands

### Check Running Containers
```sh
# List all containers (running + stopped)
docker ps -a

# List only running containers
docker ps
```

### Inspect a Container
```sh
# Full inspection
docker inspect <container_name_or_id>

# Get a specific field
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>
```

### Start / Stop / Remove
```sh
docker start <container>
docker stop <container>
docker restart <container>
docker rm <container>       # remove stopped container
docker rm -f <container>    # force remove running container
```

### Images
```sh
docker images               # list local images
docker pull <image>:<tag>   # download image
docker rmi <image>          # remove image
docker build -t <name> .    # build from Dockerfile
```

### Logs
```sh
docker logs <container>
docker logs -f <container>  # follow / tail logs
```

## Restart Policies

Control whether and how a container restarts automatically:

| Policy | Behavior |
|---|---|
| `no` | Never restart automatically (default) |
| `always` | Always restart, including on Docker daemon startup |
| `unless-stopped` | Restart unless manually stopped |
| `on-failure` | Restart only on non-zero exit codes |

**Disable auto-start:**
```sh
docker update --restart=no <container_name_or_id>
```

**Enable auto-start:**
```sh
docker update --restart=always <container_name_or_id>
```

**Verify the policy:**
```sh
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>
```

## Docker Compose (Quick Reference)

```sh
docker compose up -d        # start all services in background
docker compose down         # stop and remove containers
docker compose logs -f      # follow logs for all services
docker compose ps           # status of services
docker compose build        # rebuild images
```

## Useful Patterns

**Shell into a running container:**
```sh
docker exec -it <container> bash
# or for Alpine-based images:
docker exec -it <container> sh
```

**Copy files to/from container:**
```sh
docker cp ./local-file.txt <container>:/target/path/
docker cp <container>:/source/file.txt ./local/
```

**Clean up unused resources:**
```sh
docker system prune         # remove stopped containers, dangling images, unused networks
docker system prune -a      # also remove unused images
docker volume prune         # remove unused volumes
```

## Sources
- `development/raw/Docker-Cheat-Sheet.md`
- `development/raw/How to Create Docker Image From a Container/` *(folder — see raw for details)*

## Related
- [[windows/wiki/developer-setup]] — Docker installation on Windows (Docker Desktop vs. WSL2)
- [[README]] — Development wiki home
