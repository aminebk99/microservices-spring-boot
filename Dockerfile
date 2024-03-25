FROM eclipse-temurin:17-jdk-alpine as builder

# Set up build environment
WORKDIR /app

# Copy build script and pom.xml
COPY build_services.sh .
COPY pom.xml .

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
