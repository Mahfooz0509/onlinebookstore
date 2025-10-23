# ---------- Stage 1: Build WAR ----------
FROM maven:3.9.8-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy everything from repo
COPY . .

# Build the WAR file (skip tests for speed)
RUN mvn clean package -DskipTests

# ---------- Stage 2: Deploy WAR in Tomcat ----------
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat/webapps/

# Remove default ROOT app
RUN rm -rf ROOT

# Copy the WAR from the build stage
COPY --from=builder /app/target/*.war ./ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
