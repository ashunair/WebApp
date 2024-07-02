# Use the official Node.js image as the base image
FROM node:14

# Create and set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Install serve globally
RUN npm install -g serve

# Copy the rest of the application code to the working directory
COPY . .

# Build the application (assuming you're using a framework like React or Vue)
RUN npm run build

# Expose the port that the application will run on
EXPOSE 3000

# Start the Node.js application
CMD ["serve", "-s", "build"]
