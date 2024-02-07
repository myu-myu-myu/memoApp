FROM public.ecr.aws/bitnami/gradle:8 as serverBuild
WORKDIR /tmp
COPY ./backend ./backend
WORKDIR /tmp/backend
RUN ./gradlew build -x test
FROM public.ecr.aws/docker/library/openjdk:17-jdk
COPY --from=serverBuild /tmp/backend/build/libs/backend_kotlin2-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE 8080
CMD java -jar app.jar