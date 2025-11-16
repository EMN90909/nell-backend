# ---- Stage 1: Build Angular ----
FROM node:16-alpine as build
WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install

# Copy the rest of the project
COPY . .

# Build Angular
RUN npm run build-prod


# ---- Stage 2: Serve with Nginx ----
FROM nginx:1.15.8-alpine

# Copy nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy built Angular files
COPY --from=build /app/dist /usr/share/nginx/html
