# Developer Documentation

## Prerequisites

- Linux (Debian/Ubuntu)
- Docker & Docker Compose
- Make
- Sudo access

### Install Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

## Setup from Scratch

### 1. Clone Repository
```bash
git clone <repository-url>
cd inception
```

### 2. Configure Hosts
```bash
sudo nano /etc/hosts
```
Add: `127.0.0.1 <username>.42.fr`

### 3. Create Secrets
```bash
mkdir -p secrets
echo "your_password" > secrets/db_password.txt
echo "your_password" > secrets/db_root_password.txt
echo "your_password" > secrets/wp_admin_password.txt
echo "your_password" > secrets/wp_user_password.txt
echo "your_password" > secrets/ftp_user_password.txt
chmod 600 secrets/*.txt
```

### 4. Configure Environment
Edit `srcs/.env` with your settings:
```env
DOMAIN_NAME=<username>.42.fr
MYSQL_DB=wordpress
MYSQL_USER=wpuser
WP_ADMIN_N=<username>
FTP_USER=ftpuser
```

### 5. Build and Launch
```bash
make
```

## Using Makefile
```bash
make        # Build and start
make down   # Stop containers
make clean  # Remove containers and images
make fclean # Full cleanup (deletes data)
make re     # Rebuild from scratch
```

## Docker Compose Commands
```bash
docker compose -f srcs/docker-compose.yml build
docker compose -f srcs/docker-compose.yml up -d
docker compose -f srcs/docker-compose.yml down
docker compose -f srcs/docker-compose.yml logs -f
```

## Container Management

### Execute Commands
```bash
docker exec -it srcs-mariadb-1 bash
docker exec -it srcs-wordpress-1 bash
docker exec -it srcs-nginx-1 bash
docker exec -it srcs-redis-1 redis-cli
```

### View Logs
```bash
docker logs srcs-nginx-1
docker logs srcs-wordpress-1 --follow
```

## Volume Management

### Inspect Volumes
```bash
docker volume ls
docker volume inspect srcs_wordpress_data
```

### Check Data
```bash
ls -la /home/<username>/data/wordpress
ls -la /home/<username>/data/mariadb
```

### Backup
```bash
docker exec srcs-mariadb-1 mysqldump -u root -p$(cat secrets/db_root_password.txt) --all-databases > backup.sql
sudo tar -czf wp-backup.tar.gz /home/<username>/data/wordpress
```

## Data Persistence

Data is stored on the host and persists through container restarts:

- **MariaDB**: `/home/<username>/data/mariadb` → `/var/lib/mysql`
- **WordPress**: `/home/<username>/data/wordpress` → `/var/www/html`
- **Adminer**: `/home/<username>/data/adminer` → `/var/www/adminer`

## Service Architecture
```
Internet → NGINX:443 → WordPress:9000 → MariaDB:3306
                                     → Redis:6379
```

Only NGINX port 443 is exposed externally.

## Troubleshooting

### Build Fails
```bash
docker builder prune -a
make re
```

### Permission Errors
```bash
sudo chown -R $USER:$USER /home/$USER/data
sudo chmod -R 755 /home/$USER/data
```

### Start Fresh
```bash
make fclean
docker system prune -a --volumes
make
```

