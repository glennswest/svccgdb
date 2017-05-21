cp svccgdb.service /etc/systemd/system/svccgdb.service
systemctl disable svccgdb.service
systemctl enable svccgdb.service
systemctl start svccgdb.service
