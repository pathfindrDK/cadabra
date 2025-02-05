FROM debian:bookworm-slim AS aliro-scheduler

# Refresh packages
RUN apt-get update --fix-missing && apt-get -y upgrade && apt-get -y dist-upgrade

COPY install-deps.sh /install-deps.sh
RUN chmod +x /install-deps.sh && /install-deps.sh

# Install GitHub CLI
RUN apt install -y wget \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y
    
# Create a user and group with specific UID and GID
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID cadabra \
    && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash cadabra

COPY --chown=cadabra:cadabra ./ /workspaces/cadabra
WORKDIR /workspaces/cadabra

ARG GH_TOKEN
ARG CADABRA_VERSION
RUN ./bin/fetch-app.sh


USER cadabra
ENTRYPOINT [ "/workspaces/cadabra/entrypoint.sh" ]

