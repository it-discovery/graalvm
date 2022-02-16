FROM openjdk:17-alpine

COPY src/main/java/HelloWorld.java /sources/
WORKDIR /sources
RUN javac HelloWorld.java && rm HelloWorld.java

CMD java HelloWorld