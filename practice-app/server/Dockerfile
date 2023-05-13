# Stage 2: Build the server
FROM maven:latest as server-build
# Set the working directory inside the container
WORKDIR /app

# Copy the server files into the container
COPY . ./

# Build the server application (assuming Maven)
RUN mvn clean install -Dmaven.test.skip

# Stage 3: Create the final image
FROM openjdk:latest

# Set the working directory inside the container
WORKDIR /app

ENV ALPHA_VANTAGE_API_KEY=PUITW2P2JMTZIK0Y

# Copy the server JAR file from the server-build stage
COPY --from=server-build /app/target/group8-0.0.1-SNAPSHOT.jar ./

# Expose the port(s) that the server listens on
EXPOSE 8081

# Define the command to run the server application
CMD ["java", "-jar", "group8-0.0.1-SNAPSHOT.jar"]