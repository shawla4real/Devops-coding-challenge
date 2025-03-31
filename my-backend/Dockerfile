FROM node:18

# Create app directory
WORKDIR /app

# Copy and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Start the backend server
CMD ["node", "index.js"]
