import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Load keystore properties
val keystoreProperties = Properties()
val keystoreFile = rootProject.file("key.properties")

if (keystoreFile.exists()) {
    keystoreProperties.load(FileInputStream(keystoreFile))
    println("Keystore properties loaded successfully")
} else {
    println("key.properties file not found!")
}

android {
    namespace = "com.company.todo_app"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.company.todo_app"
        minSdk = 23
        targetSdk = project.findProperty("flutter.targetSdkVersion")?.toString()?.toInt() ?: 33
        versionCode = project.findProperty("flutter.versionCode")?.toString()?.toInt() ?: 1
        versionName = project.findProperty("flutter.versionName")?.toString() ?: "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release") // change from "debug" to "release"
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", "Todo App")
            applicationIdSuffix = ""
        }
        create("dev") {
            dimension = "default"
            resValue("string", "app_name", "Todo App Dev")
            applicationIdSuffix = ""
        }
    }
}

flutter {
    source = "../.."
}
