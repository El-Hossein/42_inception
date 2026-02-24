# User Documentation

## Services Provided

- **WordPress** - Website content management
- **MariaDB** - Database storage
- **NGINX** - Web server with HTTPS
- **Redis** - Cache for performance
- **Adminer** - Database management interface
- **FTP** - File uploads
- **Static Website** - Portfolio site
- **Grafana** - Monitoring dashboard

## Starting and Stopping

### Start
```bash
make
```

### Stop
```bash
make down
```

### Clean Everything (⚠️ deletes all data)
```bash
make fclean
```

## Accessing Services

### WordPress
- URL: `https://<username>.42.fr`
- Admin: `https://<username>.42.fr/wp-admin`
- Username: Check `srcs/.env` (WP_ADMIN_N)
- Password: `secrets/wp_admin_password.txt`

### Adminer
- URL: `https://<username>.42.fr/adminer`
- Server: `mariadb`
- Username: Check `srcs/.env` (MYSQL_USER)
- Password: `secrets/db_password.txt`

### Static Website
- URL: `http://<username>.42.fr:8080`

### FTP
- Host: `<username>.42.fr`
- Port: `21`
- Username: Check `srcs/.env` (FTP_USER)
- Password: `secrets/ftp_user_password.txt`

### Grafana
- URL: `https://<username>.42.fr/grafana`
- URL: `https://<username>.42.fr:3000`
- Username: admin
- Password: default password (admin)

## Managing Credentials

### Location
All passwords are in `secrets/` directory:
- `db_password.txt` - Database password
- `db_root_password.txt` - Root password
- `wp_admin_password.txt` - Admin password
- `wp_user_password.txt` - User password
- `ftp_user_password.txt` - FTP password

### Change Password
1. Edit secret file: `nano secrets/wp_admin_password.txt`
2. Rebuild: `make re`

## Checking Status

### Check Containers
```bash
docker ps
```
Should show 7 containers running.

### Check Logs
```bash
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
```

### Test Website
```bash
curl -k https://<username>.42.fr  # Should work
curl http://<username>.42.fr      # Should fail
```