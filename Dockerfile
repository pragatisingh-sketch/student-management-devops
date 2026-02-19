# Stage 1: Build stage
FROM maven:3.8.5-openjdk-11-slim AS build
WORKDIR /app
# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src
# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage
FROM eclipse-temurin:11-jre-jammy
WORKDIR /app
# Copy the JAR from the build stage specifically
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
# Use the PORT environment variable for Cloud Run compatibility
ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]