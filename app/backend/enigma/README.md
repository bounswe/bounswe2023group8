# Enigma Backend

## Overview
Enigma is the core backend application for our project, built using Spring Framework with Java 17 and Spring Boot 3.1.0. It facilitates server-side logic, data processing, and interaction between the frontend and the Punchcard MySQL database. This document outlines the setup, development, and deployment procedures for the Enigma backend.

## Technologies Used
- **Language:** Java 17
- **Framework:** Spring Boot 3.1.0
- **Database:** MySQL (Punchcard)
- **Containerization:** Docker
- **Version Control:** Git

## Local Development Setup

### Prerequisites
- Install [Java 17](https://jdk.java.net/17/)
- Install [Maven](https://maven.apache.org/download.cgi)
- Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- Clone this repository to your local machine.

### Installation
1. Navigate to the `enigma` directory where the `pom.xml` file is located.
2. Build the project using Maven:
    ```bash
    mvn clean install
    ```

## Running Enigma

### Locally with Empty Local Punchcard Instance

1. Start the backend services using Docker Compose:
    ```bash
    docker-compose up -d
    ```
2. The application will be accessible at `http://localhost:8081`.

### Locally with Non-Empty Local Punchcard Instance

1. Start the backend services using Docker Compose:
    ```bash
    docker-compose -f docker-compose-non-empty.yaml up -d
    ```
2. The application will be accessible at `http://localhost:8081`.

### Locally with Cloud Punchard Instance

1. Read the documentation on [How do I start the Google Cloud SQL Proxy for the cloud MySQL database connection?](scripts/start-cloud-sql-proxy.md)
2. Start the cloud sql proxy using the appropriate script for your platform:
    ```bash
    bash scripts/start-cloud-sql-proxy-<platform>.sh
    ```
3. Start the backend services using Docker Compose:
    ```bash
    docker-compose -f docker-compose-cloud.yaml up -d
    ```
4. Do not forget to stop the cloud sql proxy after you are done. Read the documentation on [How do I stop the Google Cloud SQL Proxy for the cloud MySQL database connection?](scripts/kill-cloud-sql-proxy.md) 

## Stopping Enigma
1. To stop enigma services, use the following command:
    ```bash
    docker-compose down
    ```

## API Documentation
<!-- 
to be updated
-->

## License
[License for bounswe2023group8](https://github.com/bounswe/bounswe2023group8/blob/main/LICENSE)
