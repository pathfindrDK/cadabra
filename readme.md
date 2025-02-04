# Hi

This is a basic setup to make use of the cadabra service and the aliro bridge in your project. 
The setup is based on a docker container built on debian bookworm.
The container can be used as a development container in VSCode.
The cadabra service depends on
- [https://github.com/GNOME/pango](Pango library)
- [https://github.com/harfbuzz/harfbuzz](Harfbuzz library)
These need to be installed on the host system.


## Before running starting the container
1. Get license keys from Pathfindr.
1.  update the values in the .env file 

## Start the container
1. navigate to root folder of project
2. run docker compose up

## Test aliro-schedule with curl
```bash
curl --location 'http://localhost:9001/html2pdf' \
--form 'file=@"/path/to/html_file/305809-digital-notifikation-digital-notifikation.html"'
```

## Use aliro-scehdule in java project
To interface with the aliro-schedule via Java you can use the aliro-bridge mvn package. See the demo in ./scheduler-demo. 
aliro-bridge is an interface for the aliro-schedule that will try to connect to it via port 9000.


## Install dependencies
To install the cadabra dependencies on a debian based system, you can use the install-deps.sh script:
```bash
./install-deps.sh
```
