#!/bin/bash
if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

	echo "FTP setting up"
    mkdir -p /var/www/html

    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
    mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

    # Add the FTP_USER, change his password and declare him as the owner of wordpress folder and all subfolders
    adduser $FTP_USR --disabled-password
    echo "$FTP_USR:$FTP_PASSWORD" | /usr/sbin/chpasswd
    chown -R $FTP_USR:$FTP_USR /var/www/html

	#chmod +x /etc/vsftpd/vsftpd.conf
    echo $FTP_USR | tee -a /etc/vsftpd.userlist
else
	echo "FTP already configured"
fi
echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf