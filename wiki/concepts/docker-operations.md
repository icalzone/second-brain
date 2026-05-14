---
type: concept
domains: [work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# Docker Operations

Practical Docker commands and patterns for development environments.

## Container Management

### Restart Policy

Control whether containers start automatically when the Docker daemon (re)starts.

```bash
# List all containers (running and stopped)
docker ps -a

# Check current restart policy
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>

# Disable auto-start
docker update --restart=no <container_name_or_id>

# Enable auto-start
docker update --restart=always <container_name_or_id>

# Verify the change
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' <container_name_or_id>
```

**Restart policy values:** `no` · `always` · `on-failure` · `unless-stopped`

→ Source: [Docker-Cheat-Sheet](/raw/Docker-Cheat-Sheet.md)

---

## Creating a Docker Image From a Container

Three-step process: Start container → Modify → Commit as new image.

```bash
# 1. Create and start a container from a base image
docker container run -d --name mynginx nginx

# 2. Make changes inside the container
docker exec -it mynginx bash
# install packages, modify configs, etc.
exit

# 3. Commit the container as a new image
docker commit mynginx my-custom-nginx:v1

# Verify the new image
docker images | grep my-custom-nginx
```

**Use cases:**
- Capture manual configuration changes into a reusable image
- Quick snapshot for debugging or experimentation
- Bootstrap from a customized state without writing a Dockerfile first

> **Prefer Dockerfiles** for reproducibility and version control. Use `docker commit` for quick snapshots, exploration, or when you've made manual changes you want to preserve.

→ Source: [How to Create Docker Image From a Container](/raw/How%20to%20Create%20Docker%20Image%20From%20a%20Container/How%20to%20Create%20Docker%20Image%20From%20a%20Container.md)
