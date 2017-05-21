export PSQL="postgresql://localhost:32802/postgres"
cat <<EOF  > dbsetup.sql
DROP DATABASE cg;
EOF
psql $PSQL -f dbsetup.sql
rm -f dbsetup.sql
