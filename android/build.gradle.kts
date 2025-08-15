allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Correct way to set File types in Kotlin DSL
buildDir = file("../build")

subprojects {
    buildDir = file("${rootProject.buildDir}/${name}")
    evaluationDependsOn(":app")
}

// Proper registration of the `clean` task
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
