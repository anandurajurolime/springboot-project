FROM maven:3.8.4-openjdk-11-slim AS build

WORKDIR /app

# Copy the pom.xml and the project files to the container
COPY pom.xml .

COPY src ./src

# Build the application using Maven
RUN mvn clean package -DskipTests


# Use an official OpenJDK image as the base image
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the built JAR file from the previous stage to the container
COPY --from=build /app/target/spring-boot-web.jar .

# Set the command to run the application
CMD ["java", "-jar", "spring-boot-web.jar"]

