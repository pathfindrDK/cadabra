cd /workspaces/cadabra

VERSION=$1
if [ -z "$VERSION" ]; then
    VERSION=$CADABRA_VERSION
fi
# Check if the version is set and it exists
if [ -z "$VERSION" ]; then
    echo "VERSION is not set"
    echo "Usage: fetch-app.sh [<VERSION>]"
    echo "Either CADABRA_VERSION env variable should be set or pass the VERSION"
    exit 1
fi



if [ -z "$GH_TOKEN" ]; then
    echo "GH_TOKEN is not set"
    exit 1
fi


# Check if release is available
gh release view $CADABRA_VERSION --repo pathfindrDK/cadabra-release > /dev/null

if [ $? -ne 0 ]; then
    echo "Release $CADABRA_VERSION not found"
    exit 1
fi


gh release download $CADABRA_VERSION --repo pathfindrDK/cadabra-release --pattern "cadabra-$CADABRA_VERSION.tar.gz" 
if [ $? -ne 0 ]; then
    echo "Failed to download cadabra-$CADABRA_VERSION.tar.gz"
    exit 1
fi
tar -xvf cadabra-$CADABRA_VERSION.tar.gz -C ./bin/ > /dev/null
if [ $? -ne 0 ]; then
    echo "Failed to extract cadabra-$CADABRA_VERSION.tar.gz"
    exit 1
fi

rm cadabra-$CADABRA_VERSION.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to remove cadabra-$CADABRA_VERSION.tar.gz"
    exit 1
fi

chmod +x ./bin/cadabra
if [ $? -ne 0 ]; then
    echo "Failed to make cadabra executable"
    exit 1
fi
echo "Downloaded cadabra-$CADABRA_VERSION.tar.gz, binary is in bin/cadabra"
echo "To run the binary, use ./bin/cadabra --license <LICENSE> &"
