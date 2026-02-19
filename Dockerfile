# Stage 1: Build the JAR using Maven
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
# Copy only the pom.xml first to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the package
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final lightweight runtime image
FROM eclipse-temurin:11-jre-jammy
WORKDIR /app
# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]