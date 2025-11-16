# =======================
# 1. Build frontend (if Angular/React)
# =======================
FROM node:18-alpine AS frontend-build
WORKDIR /app/client

# Copy frontend files
COPY client/package*.json ./
RUN npm install
COPY client/ .
RUN npm run build --if-present

# =======================
# 2. Build backend (Maven or Node)
# =======================
# Assuming backend is Maven
FROM maven:3.9.6-eclipse-temurin-17 AS backend-build
WORKDIR /app/server

COPY server/pom.xml ./
COPY server/src ./src

# Build backend JAR
RUN mvn -B -DskipTests clean package

# =======================
# 3. Final runtime image
# =======================
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy backend jar
COPY --from=backend-build /app/server/target/*.jar app.jar

# Copy frontend build output
COPY --from=frontend-build /app/client/dist ./static

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
