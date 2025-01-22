cat gh_token | gh auth login --hostname github.com --with-token 
gh release download v1.0.2 --repo pathfindrDK/cadabra-builder --pattern "cadabra.tar.gz"
tar -xvf cadabra.tar.gz