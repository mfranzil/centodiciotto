FROM postgres:13.3

RUN mkdir -p /docker-entrypoint-initdb.d
COPY 11_pre.sql /docker-entrypoint-initdb.d/11_create_tables.sql
COPY 12_data.sql /docker-entrypoint-initdb.d/12_restore_data.sql
COPY 13_post.sql /docker-entrypoint-initdb.d/13_finalize.sql
