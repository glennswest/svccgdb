docker build -t svccgdb .
docker tag svccgdb ctl.ncc9.com:5000/svccgdb
docker push ctl.ncc9.com:5000/svccgdb

