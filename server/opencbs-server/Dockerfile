# --- Stage 1: Build Angular ---
FROM node:16-alpine as build

WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm install

# Copy all client code
COPY . .

# Build Angular (use your existing script)
RUN npm run build-prod


# --- Stage 2: Serve with Nginx ---
FROM nginx:1.15.8-alpine

# Copy your nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy built Angular output from the build stage
COPY --from=build /app/dist /usr/share/nginx/html
