import java.io.File

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tok_tik"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.tok_tik"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

tasks.register("ensureLauncherEnabled") {
    doLast {
        try {
            val userHome = System.getProperty("user.home")
            val isWindows = System.getProperty("os.name").lowercase().contains("windows")
            val adbName = if (isWindows) "adb.exe" else "adb"
            val localAdb = File(userHome, "AppData/Local/Android/sdk/platform-tools/$adbName")
            val adb = if (localAdb.exists()) localAdb.absolutePath else "adb"

            val process = ProcessBuilder(adb, "devices").start()
            val text = process.inputStream.bufferedReader().readText()
            process.waitFor()

            for (line in text.lines()) {
                val parts = line.trim().split(Regex("\\s+"))
                if (parts.size >= 2 && parts[1] == "device") {
                    val deviceId = parts[0]
                    ProcessBuilder(
                        adb, "-s", deviceId, "shell", "cmd", "package", "enable",
                        "com.example.tok_tik/com.example.tok_tik.MainActivityNormal"
                    ).start().waitFor()
                }
            }
        } catch (_: Exception) {
            // Silently ignore if no device is connected or during offline build
        }
    }
}

tasks.matching { it.name == "assembleDebug" }.configureEach {
    finalizedBy("ensureLauncherEnabled")
}



