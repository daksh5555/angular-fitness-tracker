# Use Node.js as the build environment
FROM node:14 AS builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular application
RUN npm run build --prod

# Use Nginx to serve the built Angular app
FROM nginx:alpine

# Copy the built Angular app from the builder stage to Nginx
COPY --from=builder /usr/src/app/dist/angular-fitness-tracker /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80
