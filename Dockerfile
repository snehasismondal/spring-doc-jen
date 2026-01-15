# Use Eclipse Temurin JRE 21 on Alpine for a small, secure footprint
FROM eclipse-temurin:21-jre-alpine
# Set the working directory
WORKDIR /appContainer
# Copy your jar file from your local target folder
COPY ./target/springDocker.jar /appContainer/springDocker.jar
# Expose the port your Spring app runs on
EXPOSE 8084
# Use ENTRYPOINT instead of RUN to start the application
ENTRYPOINT ["java", "-jar", "springDocker.jar"]