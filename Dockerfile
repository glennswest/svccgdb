FROM cockroachdb/cockroach

EXPOSE 8080
EXPOSE 26257

WORKDIR /cockroach
COPY setupdb.sh /cockroach
COPY checkdb.sh /cockroach
COPY psql /cockroach

ENTRYPOINT ./checkdb.sh
