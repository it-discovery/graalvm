FROM ghcr.io/graalvm/graalvm-ce:java17-21 as graalvm

RUN gu install native-image

COPY src/main/java/HelloWorld.java /sources/
COPY src/main/resources/reflect-config.json /sources/
WORKDIR /sources
RUN javac HelloWorld.java

RUN native-image -H:ReflectionConfigurationFiles=reflect-config.json HelloWorld

FROM ubuntu

COPY --from=graalvm /sources/helloworld /helloWorld

#ENTRYPOINT [./helloWorld]
