plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.android.library")
    kotlin("plugin.serialization") version Deps.kotlinVersion
    id("com.squareup.sqldelight")
}

@OptIn(org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi::class)
kotlin {
    targetHierarchy.default()

    android {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        version = "1.0"
        ios.deploymentTarget = "14.1"
        podfile = project.file("../iosApp/Podfile")
        framework {
            baseName = "shared"
        }
    }
    
    sourceSets {
        val commonMain by getting {
            dependencies {
                //put your multiplatform dependencies here
                implementation(Deps.ktorCore)
                implementation(Deps.ktorSerialization)
                implementation(Deps.ktorSerializationJson)
                implementation(Deps.sqlDelightRuntime)
                implementation(Deps.sqlDelightCoroutinesExtensions)
                implementation(Deps.kotlinDateTime)
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val androidMain by getting {
            dependencies {
                implementation(Deps.ktorAndroid)
                implementation(Deps.sqlDelightAndroidDriver)
            }
        }

        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by getting {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)

            dependencies {
                implementation(Deps.ktorIOS)
                implementation(Deps.sqlDelightNativeDriver)
            }
        }
    }
}

android {
    namespace = "com.gilbertohdz.translator_kmm"
    compileSdk = 33
    defaultConfig {
        minSdk = 24
    }
}

sqldelight {
    database("TranslateDatabase") {
        packageName = "com.gilbertohdz.translator_kmm.database"
        sourceFolders = listOf("sqldelight")
    }
}
