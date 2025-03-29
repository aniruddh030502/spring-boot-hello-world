FROM maven:3.8.8-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy the project files

COPY pom.xml .

RUN mvn dependency:go-offline

COPY . .

RUN mvn clean package -DskipTests

# Use a lightweight JDK runtime for the final image

FROM openjdk:17-jdk-slim

WORKDIR /app
# Copy the built JAR from the builder stage

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
