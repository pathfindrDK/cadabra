https://drive.google.com/drive/folders/1yGwHh3a1djKU-yWMlbP48__v5942ASxW?usp=sharing

# Hi

This is a basic setup to make use of the cadabra service and the aliro bridge in your project. 
The setup is based on a docker container built on debian bookworm.
The container can be used as a development container in VSCode.


## Quick setup
The easiest way to get started with CadabraDocs is to use the provided Docker container.

### Setup
1. Fill in the necessary environment variables in the `.env` file

```bash
# .env
GH_TOKEN=supplied_by_pathfindr
CADABRA_LICENSE=supplied_by_pathfindr
CADABRA_VERSION=v1.0.0-alpha.1
```

1. Make sure you have [https://docs.docker.com/compose/install/](Docker) installed on your system.
1. Startup the container by running the following command in the root folder of the project:

```bash
docker compose up
```

The container will start up and run the Cadabra service on port _9000_.

Additional configuration you can do in the `.env` file:
```bash
PORT=9000 # Docker will map this host port to the cadabra service port
LOG_LEVEL=info # Set the log level for the cadabra service (debug, info, warn, error, default is info)
```

### Testing the webservice
You can verify that the cadabra service is running by sending a test request to the service.

```bash
curl --location 'http://localhost:9000/html2pdf' \
--form 'file=@"/path/to/html_file/305809-digital-notifikation-digital-notifikation.html"' --output /output/path/output.pdf
```


## Aliro-bridge
The aliro-bridge is a Java library that provides an interface to the cadabra service.
In order to use the aliro-bridge in your project, you need to add the following dependency to your `pom.xml` file:
```xml
    <dependencies>
        <dependency>
            <groupId>dev.pathfindr</groupId>
            <artifactId>alirobridge</artifactId>
            <version>1.2.5</version>
        </dependency>
    </dependencies>

    <repositories>
        <repository>
            <id>github</id>
            <url>https://maven.pkg.github.com/pathfindrDK/packages</url>
        </repository>
    </repositories>
```

_Note:_ You need to setup maven with your own github user and token (not provided by Pathfindr) to be able to download the aliro-bridge maven package from GitHub


```xml
<!-- `settings.xml` file in your maven home directory (usually `~/.m2/settings.xml`): -->
<!-- NOTE: MAKE SURE THAT settings.xml IS NOT WORLD READABLE! -->
<settings>
  <servers>
    <server>
      <id>github</id>
      <username>{your_github_user}</username>
      <password>{your_github_pat_token}</password>
    </server>
  </servers>
</settings>

```

### Example usage
The following code snippet shows how to use the aliro-bridge library to convert an HTML file to a PDF file using the cadabra service.
```java
// ....
import aliro.bridge.PDF; // Import the aliro-bridge library

public class Main {
    public static void main(String[] args) {
        String outputPdfPath = "output.pdf"; // Output file 

        try {
            // Read the file content into a string
            String htmlContent = new String("<html><body><h1>Hello, World!</h1></body></html>", StandardCharsets.UTF_8);

            // Aliro bridfe libary accepts an html string and return a ByteArrayOutputStream
            ByteArrayOutputStream pdfOutputStream = PDF.htmlToPdfOutputStream(htmlContent, false);

            // Write the ByteArrayOutputStream to a file (PDF) in the generated_files folder
            try (FileOutputStream fileOutputStream = new FileOutputStream(outputPdfPath)) {
                pdfOutputStream.writeTo(fileOutputStream);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

_Note:_ In the `scheduler-demo` you can find a demo on the usage


## VSCode
If you are using VSCode, we provide a devcontainer which simplifies development.

Before you start the container, make sure you add your GitHub token and user to the `.env` file so that the container can access the aliro-bridge library. This is required to setup maven repository access.

```bash
# User and token for maven (_not_ provided by Pathfindr)
GITHUB_USER_FOR_MAVEN=your_github_user
GITHUB_PAT_FOR_MAVEN=your_github_pat_token
```

After opening and building the container in VSCode, you can run the following command to start the cadabra service:

```bash
cadabra --license $CADABRA_LICENSE [--port 9000] [--log-level (info|debug|warn|error)] &
```

This will start the cadabra service in the background. You can then use the aliro-bridge library to interact with the service.

### Use aliro-schedule in Java project
```bash
cd ./scheduler-demo
mvn clean package
cd target
java -jar scheduler-demo-1.0.0-alpha.jar
```

## Tools
These tools are installed used in the docker container, but you can also use them to install the cadabra service on your own system.

### cadabra
Pre-requisites:
- [https://github.com/GNOME/pango](Pango library)
- [https://github.com/harfbuzz/harfbuzz](Harfbuzz library)

_Note:_ You can use the `install-deps.sh` script to install the dependencies on a debian based system.

_Note:_ To get the cadabra binary, see the `fetch-app.sh` script below.

Running the cadabra service:
```bash
cadabra --license $CADABRA_LICENSE [--port 9000] [--log-level (info|debug|warn|error)]
```


### fetch-app.sh
The `fetch-app.sh` script is used to download the cadabra service binary
Pre-requisites:
- gh CLI installed and GH_TOKEN set in your environment
- CADABRA_VERSION set or passed as an argument to the script

```bash
export GH_TOKEN=gh_token_supplied_by_pathfindr
export CADABRA_VERSION=v1.0.0-alpha.1

fetch-app.sh # or fetch-app.sh v1.0.0-alpha.1
```
This will download the cadabra service binary and place it in the `bin` folder

## Troubleshooting
- If you change the CADABRA_VERSION in the `.env` file, you need to rebuild the docker container to get the new version of the cadabra service. 
