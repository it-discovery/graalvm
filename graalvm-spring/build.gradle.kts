import org.springframework.boot.gradle.tasks.bundling.BootBuildImage

plugins {
    `java-library`
    id("org.springframework.boot") version "2.6.3"
    id("org.springframework.experimental.aot") version "0.11.2"
}

repositories {
    maven { url = uri("https://repo.spring.io/release") }
    mavenCentral()
}

dependencies {
    implementation(platform("org.springframework.boot:spring-boot-dependencies:2.6.3"))
    implementation("org.springframework.boot:spring-boot-starter-web")
}

tasks.withType<BootBuildImage> {
    builder = "paketobuildpacks/builder:tiny"
    environment = mapOf("BP_NATIVE_IMAGE" to "true")
    imageName = "graalvm-spring"
}