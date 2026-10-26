FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /workspace
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src ./src
COPY database ./database
RUN mvn -B -q -DskipTests package

FROM tomcat:11.0.4-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    /usr/local/tomcat/webapps/ROOT.war

COPY --from=build /workspace/target/EcoTravel-1.0-SNAPSHOT.war \
    /usr/local/tomcat/webapps/ROOT.war
COPY docker-entrypoint.sh /usr/local/bin/ecotravel-entrypoint
RUN chmod +x /usr/local/bin/ecotravel-entrypoint

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/ecotravel-entrypoint"]
