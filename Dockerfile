# Step 1: Use Maven image to build WAR
FROM maven:3.9.8-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build the WAR file (skip tests for speed)
RUN mvn clean package -DskipTests

# Step 2: Use Tomcat to run the built WAR
FROM tomcat:10.1-jdk17

# Clean default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into Tomcat's webapps directory
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
