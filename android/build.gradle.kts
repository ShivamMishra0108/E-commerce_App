import java.io.File

// Repositories used by all projects
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Define custom build directory
val customBuildDir = rootProject.file("../../build")

// Apply early: change buildDir for valid projects only
gradle.beforeProject {
    val project = this as org.gradle.api.Project
    if (project.name != "gradle" && project.name != "buildSrc") {
        project.buildDir = File(customBuildDir, project.name)
    }
}

// Optional: Force evaluation order for modules that depend on :app
subprojects {
    evaluationDependsOn(":app")
}

// Clean task that deletes the custom build directory
tasks.register<Delete>("clean") {
    delete(customBuildDir)
}
