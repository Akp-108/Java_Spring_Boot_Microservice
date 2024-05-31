
# Installation of build package and copy data to a dirctory 
# Build stage
FROM  maven:3.5-jdk-8-alpine AS build

WORKDIR /app

COPY src /app/src

COPY pom.xml /app

RUN mvn -f /app/pom.xml clean package


# Package stage
FROM openjdk:17-jdk-alpine

COPY target/*.jar ./app/runner.jar

ENTRYPOINT ["java","-jar","/app/runner.jar"]
