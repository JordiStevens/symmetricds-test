ARG MAVEN_SKIP_TESTS=true

FROM maven:3.9.9-amazoncorretto-21-alpine AS maven_dependency_download_from_pom

WORKDIR /mainApp
COPY --chown=dev:dev ./pom.xml ./pom.xml
RUN mkdir -p /root/.m2 && \
    mvn dependency:go-offline -U

FROM maven:3.9.9-amazoncorretto-21-alpine AS maven-build
ARG MAVEN_SKIP_TESTS

WORKDIR /mainApp
COPY --chown=dev:dev --from=maven_dependency_download_from_pom /root/.m2 /root/.m2

COPY --chown=dev:dev ./pom.xml ./
COPY --chown=dev:dev ./src ./src

RUN mvn package -Dmaven.test.skip=${MAVEN_SKIP_TESTS}

FROM eclipse-temurin:21-jre-alpine-3.21

WORKDIR /mainApp

COPY --chown=dev:dev --from=maven-build /mainApp/target/MainApp-0.0.1.jar ./application.jar

CMD apt-get update -y

# Set the default command to run the Java application
ENTRYPOINT ["java", "-Dspring.profiles.active=docker", "-Xmx2048M", "-jar", "./application.jar"]