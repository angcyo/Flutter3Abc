plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val _C_SDK = project.findProperty("C_SDK")?.toString()?.toInt() ?: flutter.compileSdkVersion
val _M_SDK = project.findProperty("M_SDK")?.toString()?.toInt() ?: flutter.minSdkVersion
val _T_SDK = project.findProperty("T_SDK")?.toString()?.toInt() ?: flutter.targetSdkVersion

//2026-4-11
println("-------------------------build.gradle.kts-------------------------")
println("gradleVersion: ${gradle.gradleVersion}")
println("AGPVersion: ${com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION}")
println("flutter.targetSdkVersion: " + flutter.targetSdkVersion + "-> ${_T_SDK}")    //36
println("flutter.compileSdkVersion: " + flutter.compileSdkVersion + "-> ${_C_SDK}")  //36
println("flutter.minSdkVersion: " + flutter.minSdkVersion + "-> ${_M_SDK}")          //24
println("flutter.ndkVersion: " + flutter.ndkVersion)                                 //28.2.13676358
println("flutter.versionCode: " + flutter.versionCode)                                //1
println("flutter.versionName: " + flutter.versionName)                               //1.0.0
println("------------------------------------------------------------------")

//2026-10-21
//-------------------------build.gradle.kts-------------------------
//gradleVersion: 9.1.0
//AGPVersion: 9.0.1
//flutter.targetSdkVersion: 36-> 36
//flutter.compileSdkVersion: 36-> 36
//flutter.minSdkVersion: 24-> 24
//flutter.ndkVersion: 28.2.13676358
//flutter.versionCode: 1
//flutter.versionName: 1.0.0
//------------------------------------------------------------------

android {
    namespace = "com.angcyo.flame.games"
    compileSdk = _C_SDK
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.angcyo.flame.games"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = _M_SDK
        targetSdk = _T_SDK
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        ndk {
            abiFilters.clear()
            abiFilters.add("arm64-v8a")
        }
    }

    signingConfigs {
        // 打包 apk 时的签名
        create("angcyo") {
            storeFile = file("../../android/angcyo.jks")
            storePassword = "angcyo"
            keyAlias = "app"
            keyPassword = "angcyo"
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("angcyo")
        }
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("angcyo")

            isMinifyEnabled = true   // 启用代码缩减与混淆
            isShrinkResources = true // 启用资源缩减
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // https://docs.flutter.dev/release/breaking-changes/default-abi-filters-android
            // Clear the automatically set filters.
            //ndk.abiFilters.clear()
            // Set your custom filters.
            //ndk.abiFilters.addAll(listOf("arm64-v8a", "armeabi-v7a"))
            //ndk.abiFilters.addAll(listOf("arm64-v8a"))
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
