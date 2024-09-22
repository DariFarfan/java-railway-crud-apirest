# Fase de construcción
FROM maven:3.8.5-openjdk-21 as build

COPY . /app
WORKDIR /app

RUN chmod +x mvnw
RUN ./mvnw package -DskipTests
RUN mv target/*.jar app.jar

# Fase de ejecución
FROM eclipse-temurin:21-jre

COPY --from=build /app/app.jar .

RUN useradd runtime
RUN chown runtime:runtime app.jar # Cambiar permisos

USER runtime

ENTRYPOINT ["java", "-jar", "app.jar"]
