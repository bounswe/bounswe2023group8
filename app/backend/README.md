# Backend

## Overview
This backend repository encompasses two primary components: the Spring Boot application named Enigma, and a MySQL database dubbed Punchcard. These components are dockerized to ensure a seamless setup and execution environment for all team members, regardless of their operating system.

### Enigma
Enigma serves as the core backend application, engineered using Java 17 alongside Spring Boot version 3.1.0. It forms the backbone of the server-side logic, handling data processing, and interactions between the frontend and the database.

### Punchcard
Punchcard represents the MySQL database utilized in this project. It is built using the latest MySQL image available on Docker, ensuring a reliable and up-to-date database management system. The database is crucial for storing, retrieving, and managing data in a structured and efficient manner.

## Setup

### Prerequisites
- Ensure you have Docker and Docker Compose installed on your machine. If not, follow the [official installation guide](https://docs.docker.com/get-docker/).
- Clone this repository to your local machine.

### Installation
1. Navigate to the root directory of the project where the `docker-compose.yaml` file is located.
2. Build the Docker images for the Enigma application and the Punchcard database by executing the following command:
   ```bash
   docker-compose build
   ```

### Running the Backend
1. Start the backend services using the provided script:
   ```bash
   ./start-backend.sh
   ```
2. Once the services are up, the Enigma application will be accessible at `http://localhost:8081`, and the Punchcard database will be accessible on `localhost` at port `3307`.
3. To stop the backend services, use the following command:
   ```bash
   docker-compose down
   ```

## API Documentation
<!-- 
currently not available
-->

## Deployment
<!--
currently not available
-->
