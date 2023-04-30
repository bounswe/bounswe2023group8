# PracticeApp Spring Backend

This is a sample Spring Boot backend project built for the cmpe352 group 8 practice application. This README will guide you on how to build and run the application.

## Prerequisites

Before you can build and run the application, you need to have the following software installed on your machine:

- [Java JDK](https://www.oracle.com/java/technologies/javase-downloads.html) version 17 or higher
- [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) Community or Ultimate edition

## Getting Started

To get started, follow the steps below:

1. Clone the repository to your local machine using the following command:

   ```
   git clone https://github.com/bounswe/bounswe2023group8.git
   ```

2. Open IntelliJ IDEA and from the "File" toolbar select "Open..." on the `/server` folder. Choose "Maven" as the external model and click "Next".

3. Navigate to the directory where you cloned the repository and select the `pom.xml` file.  

4. IntelliJ will import the project and download all the necessary dependencies.

5. Once the project is imported, you can run the application by clicking the "Run" button on the toolbar.

## Testing the Application

To test the application, you can use the following endpoints:

- `GET localhost:8080/api/user/all`: Returns a list of all users in the database.
- `POST localhost:8080/api/user`: Creates a new user in the database. The request body should be a JSON object with the following fields:
  - `username`: The username of the user.
  - `password`: The password of the user.

You can test these endpoints using [Postman](https://www.postman.com/downloads/) or any other HTTP client. 

## Guides and Tutorials

- [Spring Boot Documentation](https://spring.io/projects/spring-boot#learn)
- [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
- [Building REST services with Spring](https://spring.io/guides/tutorials/rest/)
