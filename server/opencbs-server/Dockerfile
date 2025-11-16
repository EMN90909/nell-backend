#############################################
# 1. BUILD BACKEND (SPRING BOOT)
#############################################
FROM maven:3.8.6-openjdk-8 AS backend-build

WORKDIR /backend

# Copy backend project files
COPY opencbs-core ./opencbs-core
COPY opencbs-loans ./opencbs-loans
COPY opencbs-savings ./opencbs-savings
COPY opencbs-server ./opencbs-server
COPY pom.xml .

# Download dependencies
RUN mvn -q -DskipTests dependency:resolve

# Build backend
RUN mvn -q -DskipTests package

#############################################
# 2. BUILD FRONTEND (ANGULAR)
#############################################
FROM node:16-alpine AS frontend-build

WORKDIR /frontend

COPY client/package.json client/package-lock.json* ./
RUN npm install

COPY client/ .
RUN npm run build-prod


#############################################
# 3. MERGE FRONTEND INTO BACKEND STATIC
#############################################
FROM openjdk:8-jdk-alpine AS final

WORKDIR /app

# Copy Spring Boot JAR
COPY --from=backend-build /backend/opencbs-server/target/*.jar app.jar

# Copy Angular build output into Spring Boot static folder
RUN mkdir -p /app/static
COPY --from=frontend-build /frontend/dist /app/static

#############################################
# 4. RUN APP
#############################################
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
