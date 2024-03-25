# Build stage
FROM maven:3.8.3-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy Maven dependencies file
COPY pom.xml .

# Resolve dependencies
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY . .

# Make build script executable
RUN chmod +x build_services.sh

# Resolve dependencies and build application
RUN ./build_services.sh

# Runtime image
FROM eclipse-temurin:17-jdk-alpine

# Set up volume
VOLUME /tmp

# Copy jar from builder stage
COPY --from=builder /app/target/microservices-spring-0.0.1-SNAPSHOT.jar /app.jar

# Entry point
ENTRYPOINT ["java","-jar","/app.jar"]
