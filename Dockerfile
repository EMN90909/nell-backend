# Use Maven + Java to build backend
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy backend folder (server)
COPY server/pom.xml ./ 
COPY server/src ./src

# Build JAR
RUN mvn -B -DskipTests clean package

# Runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy built JAR
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
