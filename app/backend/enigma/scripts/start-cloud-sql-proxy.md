
### How do I start the Google Cloud SQL Proxy for the cloud MySQL database connection? 

1. Ask one of the cloud admins to create a service account JSON credentials key which has Cloud SQL - Client authorization. 
2. Save the JSON credentials file somewhere in your computer and copy the file path.
3. Open `engima/.env`.
4. Paste the file path to a variable named `MYSQL_CREDENTIALS_PATH`.
5. Save the `enigma/.env` file. 
6. Run the correct `connect-db-<platform>.sh` script using `bash`. 
7. Congrats. Now `localhost:3307` is connected to the cloud MySQL instance using a proxy. 
