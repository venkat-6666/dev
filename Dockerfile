# Stage 1: Build the application
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Install git (alpine does not include git by default)
RUN apk add --no-cache git

# Clone the repo directly into the container
RUN git clone https://github.com/venkat-6666/pro.git /app

# Install dependencies
RUN npm install

# Build the Vite project
RUN npm run build


# Stage 2: Final image to serve static files
FROM node:20-alpine

WORKDIR /app

# Install serve globally
RUN npm install -g serve@14.2.3

# Copy only the built files from stage 1
COPY --from=build /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]
