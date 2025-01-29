FROM debian:bookworm-slim AS base

# Refresh packages
RUN apt-get update --fix-missing && apt-get -y upgrade && apt-get -y dist-upgrade 

# Install basic tools and maven
RUN apt-get install -y \ 
    sudo mc git curl wget \
    maven

COPY install-deps.sh /install-deps.sh
RUN chmod +x /install-deps.sh && /install-deps.sh

# Install GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y
    
# Create a user and group with specific UID and GID
ARG USERNAME=cadabra
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Copy Maven auth settings dummy file
RUN mkdir -p -m 755 /home/$USERNAME/.m2 \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/.m2
    
COPY --chown=${USERNAME}:${USERNAME} settings.xml /home/$USERNAME/.m2/settings.xml

USER $USERNAME
