# ============================
# Step 1: Build WAR with Maven + Java 17
# ============================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

# Build the WAR (skip tests)
RUN mvn clean package -DskipTests

# ============================
# Step 2: Run WAR with webapp-runner
# ============================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy WAR and webapp-runner.jar from build stage
COPY --from=build /app/target/dependency/webapp-runner.jar .
COPY --from=build /app/target/onlinebookstore.war .

# Expose port 8080
EXPOSE 8080

# Start the app
CMD ["java", "-jar", "webapp-runner.jar", "onlinebookstore.war"]
