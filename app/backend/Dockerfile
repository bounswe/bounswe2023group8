# Use the official MySQL image as the base image
FROM mysql:latest

# Copy the dump file into the docker-entrypoint-initdb.d directory
# so that it is imported on container startup.
COPY enigma/mysql/image/all-databases.sql /docker-entrypoint-initdb.d/
