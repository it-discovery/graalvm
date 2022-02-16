FROM ghcr.io/graalvm/graalvm-ce:java17-21.3.0 as graalvm

RUN microdnf update && microdnf install -y unzip  

RUN gu install native-image

RUN curl https://downloads.gradle-dn.com/distributions/gradle-7.4-bin.zip --output gradle.zip && \
	unzip -d /home gradle.zip && \
	mv /home/gradle-7.4 /home/gradle

WORKDIR /home/gradle

COPY build.gradle.kts /home/gradle/build.gradle.kts
COPY settings.gradle.kts /home/gradle/settings.gradle.kts
COPY . /home/gradle/

RUN --mount=type=cache,target=/home/gradle/.gradle /home/gradle/bin/gradle --no-daemon nativeCompile && \
	cp /home/gradle/build/native/nativeCompile/graalvm-java /opt/graalvm && \
	rm -rf /home/gradle/graalvm*

FROM ubuntu as ubuntu

RUN apt-get update && apt-get install -y upx

COPY --from=graalvm /opt/graalvm /opt

RUN upx /opt/graalvm

FROM scratch

COPY --from=ubuntu /opt/graalvm /graalvm

ENTRYPOINT ["./graalvm"]
