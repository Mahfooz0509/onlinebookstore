# ---------- BUILD STAGE ----------
FROM maven:3.9.8-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- DEPLOY STAGE ----------
FROM tomcat:10.1.48-jdk17-temurin

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR as ROOT.war
COPY target/onlinebookstore.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

