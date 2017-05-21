docker kill svccgdb.ncc9.com
docker rm svccgdb.ncc9.com
docker run -d  -P \
--net="" \
--name=svccgdb.ncc9.com \
-v "/data/svccgdb.ncc9.com:/cockroach/cockroach-data"  \
svccgdb start --insecure

