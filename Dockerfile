# inherit from an existing image to add the functionality
FROM node:20-alpine3.18

# Create a non-root user and switch to it

RUN addgroup app && adduser -S -G app app


# Set the working directory and assign ownership to the non-root user
WORKDIR /app

# Copy the package.json and package-lock.json files into the image.
COPY package*.json ./

# Change ownership of the working directory to the non-root user
# This step is crucial to avoid permission issues during npm install
RUN chown -R node:node /app

# Install the dependencies.
RUN npm install

# Copy the rest of the source files into the image.
COPY . .

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD npm run dev
