# Step 1: Build the WAR file using Maven
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the WAR with webapp-runner
FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/dependency/webapp-runner.jar .
COPY --from=build /app/target/onlinebookstore.war .
EXPOSE 8080
CMD ["java", "-jar", "webapp-runner.jar", "onlinebookstore.war"]
