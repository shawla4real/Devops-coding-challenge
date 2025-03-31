
# Use the official Node.js image as a base
FROM node:14-alpine
 
# Set the working directory
WORKDIR /app
 
# Copy package.json and install dependencies
COPY package.json ./
RUN npm install
 
# Copy the rest of the application code
COPY . .
 
# Build the React application
RUN npm run build
 
# Serve the built application using a simple HTTP server
RUN npm install -g serve
CMD ["serve", "-s", "build"]
 
# Expose the port the app runs on
EXPOSE 3000