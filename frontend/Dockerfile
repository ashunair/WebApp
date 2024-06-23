# Use an official Nginx image
FROM nginx:latest

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the frontend files into the container
COPY . /usr/share/nginx/html

# Expose the port the app runs on
EXPOSE 3000

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
