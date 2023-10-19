
### How do I stop the Google Cloud SQL Proxy from listening (connecting) to localhost:3307

1. Find process `ps | grep cloud_sql_proxy`
2. Kill process based on its id `kill <pid>`
