# ---------- BUILD STAGE ----------
FROM maven:3.9.8-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- DEPLOY STAGE ----------
FROM tomcat:10.1-jdk17
WORKDIR /usr/local/tomcat
RUN rm -rf webapps/*
# Copy WAR file with its actual name
COPY --from=builder /app/target/onlinebookstore.war webapps/onlinebookstore.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
