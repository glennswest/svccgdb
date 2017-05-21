./cockroach.sh start --insecure &
sleep 4
export PSQL="postgresql://localhost:26257/postgres"
if [ "$( ./psql ${PSQL} -tAc "SELECT 1 FROM pg_database WHERE datname='cg'" )" = '1' ]; then     echo "Database already exists"; else     echo "Database does not exist"; ./setupdb.sh; fi
tail -f /dev/null
