#!/bin/bash
set -e

FTP_PASSWORD=$(cat /run/secrets/ftp_user_password)

if ! id "$FTP_USER" &>/dev/null; then
    useradd -m -s /bin/bash "$FTP_USER"
fi
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

FTP_ROOT="/var/ftp/wordpress/ftp"
mkdir -p $FTP_ROOT/files

echo "FTP Test File" > $FTP_ROOT/files/test.txt

echo "$FTP_USER" > /etc/vsftpd.userlist
mkdir -p /var/run/vsftpd/empty

cat > /etc/vsftpd.conf << EOF
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40005
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
local_root=$FTP_ROOT
EOF

chown -R $FTP_USER:$FTP_USER $FTP_ROOT $FTP_ROOT/files
exec /usr/sbin/vsftpd /etc/vsftpd.conf