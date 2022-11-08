FROM guranchik/debian:0.2
RUN apt -y update && apt -y install \
    postgresql \ 
    postgresql-contrib
COPY --chown=postgres:postgres ["conf/postgresql.conf", "/etc/postgresql/13/main/"]
COPY --chown=postgres:postgres ["conf/pg_hba.conf", "/etc/postgresql/13/main/"]
EXPOSE 5432
USER postgres
ENTRYPOINT ["/usr/lib/postgresql/13/bin/postgres", "-D", "/etc/postgresql/13/main/","-i"]
