VERSION=v1.0.0
cd $WORKSPACE_FOLDER
cat $WORKSPACE_FOLDER/gh_token | gh auth login --hostname github.com --with-token 
gh release download $VERSION --repo pathfindrDK/cadabra-release --pattern "cadabra-$VERSION.tar.gz" 
tar -xvf cadabra-$VERSION.tar.gz -C ./bin/
rm cadabra-$VERSION.tar.gz