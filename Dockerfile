# ---------- BUILD STAGE ----------
FROM maven:3.9.8-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- DEPLOY STAGE ----------
# Use official Tomcat base image
FROM tomcat:10.1.48-jdk17-temurin

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy generated WAR from Maven target directory
COPY target/onlinebookstore.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

