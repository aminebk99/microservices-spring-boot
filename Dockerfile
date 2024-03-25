FROM eclipse-temurin:17-jdk-alpine as builder

# Set up build environment
WORKDIR /app

# Copy build script and pom.xml
COPY build_services.sh .
COPY pom.xml .

# Resolve dependencies and build application
RUN chmod +x build_services.sh && ./build_services.sh

# Runtime image
FROM eclipse-temurin:17-jdk-alpine

# Set up volume
VOLUME /tmp

# Copy jar from builder stage
COPY --from=builder /app/target/microservices-spring-0.0.1-SNAPSHOT.jar /app.jar

# Entry point
ENTRYPOINT ["java","-jar","/app.jar"]

# Build script
RUN echo "#!/bin/bash" >> build_services.sh && \
    echo "set -e" >> build_services.sh && \
    echo "echo 'Building microservices-spring-0.0.1-SNAPSHOT.jar...'" >> build_services.sh && \
    echo "(mvn clean package -DskipTests)" >> build_services.sh && \
    echo "echo 'Building chat-service...'" >> build_services.sh && \
    echo "(cd ./chat-service && mvn clean package -DskipTests)" >> build_services.sh && \
    echo "echo 'Building user-service...'" >> build_services.sh && \
    echo "(cd ./user-service && mvn clean package -DskipTests)" >> build_services.sh && \
    echo "echo 'Building post-service...'" >> build_services.sh && \
    echo "(cd ./post-service && mvn clean package -DskipTests)" >> build_services.sh && \
    echo "echo 'Starting Docker containers...'" >> build_services.sh && \
    echo "(docker-compose up)" >> build_services.sh && \
    chmod +x build_services.sh
