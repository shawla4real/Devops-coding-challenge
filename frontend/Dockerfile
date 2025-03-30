# Stage 1: Build the React application
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Clean npm cache and install dependencies
RUN npm cache clean --force && \
    npm install postcss postcss-safe-parser --legacy-peer-deps && \
    npm install && \
    npm ci

# Set NODE_OPTIONS to bypass OpenSSL errors
ENV NODE_OPTIONS=--openssl-legacy-provider

# Copy source files (including public/ and src/)
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the production build
FROM node:18-alpine

# Install serve globally
RUN npm install -g serve

# Set working directory
WORKDIR /app

# Copy build output from builder stage
COPY --from=builder /app/build ./build

# Expose port and run serve
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
