FROM postgres:13.3


LABEL org.opencontainers.image.created="2021-05-27T10:47:00+02:00"
LABEL org.opencontainers.image.authors="Matteo Franzil <matteo.franzil@studenti.unitn.it>, Claudio Facchinetti <claudio.facchinetti@studenti.unitn.it>"
LABEL org.opencontainers.image.url="https://github.com/mfranzil/centodiciotto/"
LABEL org.opencontainers.image.version="2.0.2"
LABEL org.opencontainers.image.vendor="CentoDiciotto"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.ref.name="mfranzil/centodiciotto-psql"
LABEL org.opencontainers.image.title="CentoDiciotto SQL Server"


RUN mkdir -p /docker-entrypoint-initdb.d
COPY 11_pre.sql /docker-entrypoint-initdb.d/11_create_tables.sql
COPY 12_data.sql /docker-entrypoint-initdb.d/12_restore_data.sql
COPY 13_post.sql /docker-entrypoint-initdb.d/13_finalize.sql
