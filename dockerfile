# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17-slim AS builder
WORKDIR /app
COPY pom.xml /app/
RUN mvn dependency:go-offline
COPY src /app/src
RUN mvn package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=postgres
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://petclinic-postgres:5432/petclinic
ENV SPRING_DATASOURCE_USERNAME=petclinic
ENV SPRING_DATASOURCE_PASSWORD=petclinic
ENTRYPOINT ["java", "-jar", "app.jar"]


