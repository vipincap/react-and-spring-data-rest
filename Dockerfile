# Use the official OpenJDK 8 image from the Docker Hub
FROM openjdk:8-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the application JAR file into the container
COPY target/react-and-spring-data-rest-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
