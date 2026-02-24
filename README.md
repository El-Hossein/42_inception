_This project has been created as part of the 42 curriculum by <username>._

# Inception

## Description

Inception is a system administration project focused on Docker containerization. The goal is to set up a small infrastructure with different services using Docker Compose:

- **NGINX** with TLSv1.3
- **WordPress** with PHP-FPM
- **MariaDB** database
- **Redis** cache (bonus)
- **Adminer** database manager (bonus)
- **FTP Server** (bonus)
- **Static Website** (bonus)
- **Grafana** monitoring dashboards (bonus) :Grafana is included as a bonus service to visualize metrics from the infrastructure.


All services run in isolated containers, communicate through a Docker network, and persist data using volumes.

## Instructions

### Prerequisites
- Virtual Machine (Debian/Ubuntu)
- Docker and Docker Compose
- Domain configured in `/etc/hosts`: `127.0.0.1 <username>.42.fr`

### Installation
```bash
git clone <repository-url>
cd inception
make
```

### Access
- WordPress: `https://<username>.42.fr`
- Adminer: `https://<username>.42.fr/adminer/`
- Static site: `http://<username>.42.fr:8080`

### Commands
- `make` - Build and start
- `make down` - Stop services
- `make fclean` - Clean everything
- `make re` - Rebuild from scratch

## Technical Choices

### Virtual Machines vs Docker
**Docker** is lightweight (shares OS kernel), starts in seconds, and uses less resources. **VMs** provide stronger isolation but are heavier and slower.

### Secrets vs Environment Variables
**Docker Secrets** store passwords securely in `/run/secrets/` (not visible in logs). **Environment Variables** store non-sensitive config in `.env` (domain names, usernames).

### Docker Network vs Host Network
**Custom Docker Network** provides isolation and automatic DNS between containers. **Host Network** has no isolation and is forbidden in this project.

### Docker Volumes vs Bind Mounts
**Bind Mounts** (used here) map directly to `/home/<username>/data/` for easy backup. **Docker Volumes** are managed by Docker in `/var/lib/docker/volumes/`.

## Resources

### Official Documentation
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress CLI Documentation](https://wp-cli.org/)
- [MariaDB Documentation](https://mariadb.org/documentation/)

### Tutorials & Articles
- [Docker Secrets Management](https://docs.docker.com/engine/swarm/secrets/)
- [NGINX SSL Configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [Dive into Docker and Docker-Compose](https://medium.com/@afatir.ahmedfatir/unveiling-42-the-network-inception-a-dive-into-docker-and-docker-compose-cfda98d9f4ac)
- [understand docker and docker-compose in darija](https://www.tldraw.com/f/mSk3tLwrohpXaGZDFg2o8?d=v-31032.-6239.18287.8908.DbW6OvsmQi_JwATaOxYd2)

### AI Usage
Claude was used for:
- Learning Docker concepts (networks, volumes, secrets)
- Debugging container connectivity and permissions
- Reviewing Dockerfiles for best practices
- Understanding NGINX and SSL/TLS configuration

All AI-generated content was reviewed, tested, and understood before use.