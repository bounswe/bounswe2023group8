# Use Maven with JDK 17 to build the project
FROM maven:3.8.3-openjdk-17-slim as builder

LABEL authors="bahadirgezer"
WORKDIR /usr/src/app

# Copy the Maven pom.xml file and download dependencies to take advantage of Docker layer caching
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the project source and build it
COPY src ./src
RUN mvn package

# Use JDK 17 to run the application
FROM openjdk:17-slim

# Copy the built artifact from the builder stage
COPY --from=builder /usr/src/app/target/enigma-0.0.1.jar /usr/app/enigma.jar

# Expose the application port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/usr/app/enigma.jar"]
