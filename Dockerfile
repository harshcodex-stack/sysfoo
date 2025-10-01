# ---- Build stage ----
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /build
COPY . .
RUN mvn package -DskipTests

# ---- Runtime stage ----
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy the built JAR from /build/target/
COPY --from=build /build/target/sysfoo*.jar /app/sysfoo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "sysfoo.jar"]

