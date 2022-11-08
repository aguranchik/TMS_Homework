FROM guranchik/debian:0.2
# RUN groupadd -r postgres && \
#     useradd -r -g postgres --home-dir=/var/lib/postgresql --shell=/bin/bash postgres && \
#     mkdir -p /var/lib/postgresql && \
#     chown -R postgres:postgres /var/lib/postgresql
# RUN mkdir -p /var/run/postgresql && \
#     chown -R postgres:postgres /var/run/postgresql && \
#     chmod 777 /var/run/postgresql
RUN apt -y update && apt -y install \
    postgresql \ 
    postgresql-contrib
#    service postgresql start
COPY --chown=postgres:postgres ["conf/postgresql.conf", "/etc/postgresql/13/main/"]
COPY --chown=postgres:postgres ["conf/pg_hba.conf", "/etc/postgresql/13/main/"]
EXPOSE 5432
USER postgres
ENTRYPOINT ["/usr/lib/postgresql/13/bin/postgres", "-D", "/etc/postgresql/13/main/","-i"]