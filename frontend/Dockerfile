# Use the official Node.js image as the base image
FROM node:14

# Create and set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package.json ./

# Install the dependencies
RUN npm install


# Copy the rest of the application code to the working directory
COPY . .


# Expose the port that the application will run on
EXPOSE 3000

# Start the Node.js application
CMD ["npx", "serve", "-s", "."]
