# ===========================================================
# 1. BUILD FRONTEND
# ===========================================================
FROM node:18 AS frontend

WORKDIR /app

COPY client ./client

WORKDIR /app/client
RUN npm install
RUN npm run build --if-present


# ===========================================================
# 2. BUILD BACKEND (Spring Boot)
# ===========================================================
FROM maven:3.9.6-eclipse-temurin-17 AS backend

WORKDIR /app
COPY . .

# Build whole multi-module project
RUN mvn -B -DskipTests clean package


# ===========================================================
# 3. FINAL RUNTIME IMAGE
# ===========================================================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy Spring Boot jar
COPY --from=backend /app/opencbs-server/target/*.jar app.jar

# Copy built frontend into Spring Boot's static folder
COPY --from=frontend /app/client/dist ./static

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
