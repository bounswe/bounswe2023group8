# Stage 2: Build the server
FROM maven:3.8.5-openjdk-17 as annotation-build
# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file first to leverage Docker cache
COPY ./pom.xml ./pom.xml

# Download dependencies - they will be cached unless pom.xml changes
RUN mvn dependency:go-offline -B

# Copy the server files into the container
COPY . ./

# Build the server application (assuming Maven)
RUN mvn clean package

# Stage 3: Create the final image
FROM openjdk:17-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the server JAR file from the server-build stage
COPY --from=annotation-build /app/target/annotation-0.0.1.jar ./

# Expose the port(s) that the server listens on
EXPOSE 8080

# Define the command to run the server application
CMD ["java", "-jar", "annotation-0.0.1.jar"]
