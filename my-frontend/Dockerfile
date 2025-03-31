# Build stage
FROM node:16-alpine as build
WORKDIR /app

# First install only dependencies to leverage Docker cache
COPY package*.json ./

# Install dependencies with explicit versions
RUN npm install -g npm@latest && \
    npm install --legacy-peer-deps && \
    npm install ajv@^8.12.0 schema-utils@^4.2.0 --save

# Copy source files
COPY . .

# Build the app
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]