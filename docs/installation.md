## Environment setup
- [Install NodeJS](https://nodejs.org/es/download/current/)
- Install Python, virutal env, configure it, and install pip `requirements.txt` file:
```bash
cd code
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get install python3.10 python3.10-venv build-essential
sudo apt install nodejs
python3.10 -m venv env

# Customize activate script
cat <<EOF >> env/bin/activate
export CODEQL_CLIS_ROOT=<codeql clis dir>
export TSM_TMP=<tmp folder to use>
EOF

# Activate venv
source env/bin/activate
# Install pip dependencies
pip install -r requirements.txt
```

- Install CBC solver: 
```
# Linux
sudo apt-get install coinor-cbc

# MacOS
brew tap coin-or-tools/coinor
brew install coin-or-tools/coinor/cbc
```

## Installing a CLI

1. Configure the CLIs dir, which should be set in the `$CODEQL_CLIS_ROOT` env var
2. Download the required version from https://github.com/github/codeql-cli-binaries/releases/
3. Unzip the downloaded file with the following format: `$CODEQL_CLIS_ROOT/codeqlcli-v<semver version>`

Right now, we are using the following versions:
- Worse: [v2.5.2](https://github.com/github/codeql-cli-binaries/releases/tag/v2.5.2)
- V0: [v2.10.5](https://github.com/github/codeql-cli-binaries/releases/tag/v2.10.5)

## Instaling the CodeQL libraris

First, to install **lib-worse** as mentioned in [README.md](../lib-worse/README.md).

After, for running the v0 evaluations, in the latest trials the [`3165babc887c1c1127f7f028493380ceca004b2e`](https://github.com/github/codeql/commit/3165babc887c1c1127f7f028493380ceca004b2e) commit of CodeQL was being used. Using the same one. Ver [aca](https://tesisdepalbi.deno.dev/2023-04-14-retomando-la-tesis#como-clonar-un-solo-commit-de-github) como clonar solo un commit.


## Install ql pack dependencies

1. Ir a root_dir del repo/ql
2. Con la ultima version de la cli (2.13.1), hacer `codeql pack install`