# 1. Use JRE instead of JDK for a smaller, more secure runtime image
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# 2. Use a wildcard to find the JAR. 
# This prevents the build from breaking if you change the project version in pom.xml
COPY target/*.jar app.jar

# 3. Standard Cloud Run port
EXPOSE 8080

# 4. Use the PORT env variable provided by Cloud Run (defaults to 8080 if not set)
ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]
