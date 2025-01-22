# Setup your dev environment

### Install dependencies
```bash
mkdir -p .ssh
ssh-keyscan github.com >> /root/.ssh/known_hosts
ssh-keygen -t ed25519 -C "laszlo@pathfindr.dev" -f ./.ssh/id_ed25519 -N ""
```

#### Add the public key to your github account to the weasy repo
```bash
cat ./.ssh/id.pub
```
needs to go to https://github.com/pathfindrDK/weasy/settings/keys
