# Build stage - Using Node 18 which is a good compromise for React projects
FROM node:18.20.2-alpine as build
WORKDIR /app

# First install only dependencies to leverage Docker cache
COPY package*.json ./

# Install specific npm version compatible with Node 18
RUN npm install -g npm@8.19.4 && \
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