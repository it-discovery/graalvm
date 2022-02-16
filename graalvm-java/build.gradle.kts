plugins {
    id("application")
    id("org.graalvm.buildtools.native") version "0.9.9"
}

graalvmNative {
    binaries {
        named("main") {
            imageName.set("graalvm-java")
            mainClass.set("HelloWorld")
        }
    }
}