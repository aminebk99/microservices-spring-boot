#!/bin/bash

# Build chat-service
echo "Building microservices-spring-0.0.1-SNAPSHOT.jar..."
(mvn clean package -DskipTests)

# Build chat-service
echo "Building chat-service..."
(cd ./chat-service && mvn clean package -DskipTests)

# Build user-service
echo "Building user-service..."
(cd ./user-service && mvn clean package -DskipTests)

# Build post-service
echo "Building post-service..."
(cd ./post-service && mvn clean package -DskipTests)

# Start Docker containers
echo "Starting Docker containers..."
docker-compose up -d --build
