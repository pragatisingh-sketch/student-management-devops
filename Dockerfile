# Use the Java 11 runtime
FROM eclipse-temurin:11-jre-jammy
WORKDIR /app

# Copy the specific snapshot JAR from your local target folder
COPY target/student-management-0.0.1-SNAPSHOT.jar app.jar

# Standard port for Cloud Run
EXPOSE 8080

ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]










# # Use a lightweight Java 11 runtime
# FROM eclipse-temurin:11-jre-jammy
# WORKDIR /app

# # Copy the JAR you already built locally into the container
# COPY target/*.jar app.jar

# # Expose the port Cloud Run uses
# EXPOSE 8080

# # Run the JAR
# ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]





# # # Stage 1: Build the application using Maven and Java 11
# # FROM maven:3.8.5-openjdk-11-slim AS build
# # WORKDIR /app

# # # Copy the project files
# # COPY pom.xml .
# # COPY src ./src

# # # Build the JAR file inside the container
# # RUN mvn clean package -DskipTests

# # # Stage 2: Create the final runtime image
# # FROM eclipse-temurin:11-jre-jammy
# # WORKDIR /app

# # # Copy only the built JAR from the previous stage
# # COPY --from=build /app/target/*.jar app.jar

# # # Cloud Run requires the app to listen on the port defined by the $PORT env var
# # EXPOSE 8080
# # ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]