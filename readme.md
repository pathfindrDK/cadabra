# Setup your dev environment

1. Open the folder in vscode 
2. Create environment file
```bash
#.env

GH_TOKEN=github_pat_token_supplied_by_pathfindr
GITHUB_USER_FOR_MAVEN=github_user_required_for_maven
GITHUB_PAT_FOR_MAVEN=github_pat_required_for_maven

CADABRA_LICENSE=license_key_supplied_by_pathfindr
CADABRA_VERSION=v1.0.0-alpha
```
3. Rebuild and open the container


# How to ...

## Fetch cadabra binary
The cadabra binary is released by Pathfindr Aps and is not part of the repository. To fetch the binary, run the following command:

```bash
# if CADABRA_VERSION is set in .env
fetch-app.sh
# or, for specific version
fetch-app.sh v1.0.0-alpha
```

Before you fetch the binary, make sure you have set the `CADABRA_VERSION` and `GH_TOKEN` in your `.env` file.

## Run the cadabra binary
To run the cadabra binary, run the following command:
```bash
# if CADABRA_LICENSE is set in .env
cadabra --license $CADABRA_LICENSE &
# or, for specific license
cadabra --license license_key_supplied_by_pathfindr &
```
Note the & at the end of the command. It is used to run the cadabra service in the background.

This will start the cadabra service on port 8000.
To start the cadabra service on a different port, run the following command:
```bash
cadabra --license $CADABRA_LICENSE --port 9000 &
```

## Build the scheduler demo package
We set up a basic java package to demonstrate how to use the scheduler. To build the package, run the following command:
```bash
cd scheduler
mvn clean package
java -jar target/scheduler-demo-1.0-0-alpha.jar $WORKSPACE_FOLDER/test.html
```

Before you build the package make sure you have set the `GITHUB_USER_FOR_MAVEN` and `GITHUB_PAT_FOR_MAVEN` in your `.env` file.

Before running the jar file, make sure 
1. You fetched the cadabra binary
2. You have set the `CADABRA_LICENSE` in your `.env` file.
3. You are running cadabra service on port 9000 (default port is 8000)




## Aliro bridge setup in your project
Aliro bridge mvn packages are released by Pathfindr Aps and are not part of the repository. To use them in you project, you need to:
1. Add Aliro bridge as a dependency in your project to pom.xml
```xml
    <dependencies>
        <dependency>
            <groupId>dev.pathfindr</groupId>
            <artifactId>alirobridge</artifactId>
            <version>1.0.20</version>
        </dependency>
    </dependencies>

    <repositories>
        <repository>
            <id>github</id>
            <url>https://maven.pkg.github.com/pathfindrDK/packages</url>
        </repository>
    </repositories>
```
2. Although the pacakges are public, you need a github user and PAT token to download them. Add the following to your settings.xml file in your maven installation folder:
```xml
<settings>
  <servers>
    <server>
      <id>github</id>
      <username>github_user</username>
      <password>github_pat</password>
    </server>
  </servers>
</settings>
```

## Install dependencies
To install the cadabra dependencies, run the following command:
```bash
./install-deps.sh
```

This will install the dependencies on a debian based system