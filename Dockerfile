# Extend official PostgreSQL image
FROM postgres:15-alpine

# Copy init script - runs automatically on first container start
COPY config/init.sql /docker-entrypoint-initdb.d/
RUN chmod 644 /docker-entrypoint-initdb.d/init.sql

# PostgreSQL default port
EXPOSE 5432
