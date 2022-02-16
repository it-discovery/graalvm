FROM ghcr.io/graalvm/graalvm-ce:java17-21.3.0 as graalvm

RUN gu install native-image

COPY src/main/java/HelloWorld.java /sources/
WORKDIR /sources
RUN javac HelloWorld.java

RUN native-image HelloWorld

FROM ubuntu

COPY --from=graalvm /sources/HelloWorld /helloworld

ENTRYPOINT [./helloWorld]
