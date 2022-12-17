# syntax=docker/dockerfile:1.3-labs
FROM python:3.10.5-bullseye as compile-image

# Dependencies installation
WORKDIR /tmp

COPY requirements.txt .
RUN python -m venv /opt/venv
# Make sure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"
# Install required dependencies
RUN pip install -r requirements.txt

FROM python:3.10.5-bullseye as build-image

# Configuring container user
ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID tsm
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID tsm
USER tsm

COPY --from=compile-image --chown=tsm /opt/venv /opt/venv
# Make sure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"

# Install cbc as root
USER 0
RUN \
    apt-get update \
    && apt-get install -y coinor-cbc

USER tsm

# Moving application artifacts
WORKDIR /app

# Copy eveything needed to run the orchestrator
# TODO: Trim this down somehow
COPY . ./

# Volumes that need to be mounted in this container to work
# /results: Results directory
# /worse_lib: Worse CodeQL lib
# /bigtmp: /tesis/tmp, so that is a higher volume tmp directory
# /cli: CodeQL CLI
# /ql: TSM CodeQL sources root
RUN cat <<EOF > config.json
{
  "codeQLExecutable": "/cli/codeql",
  "codeQLSourcesRoot": "/ql",
  "workingDirectory": "/bigtmp/wd",
  "resultsDirectory": "/results",
  "worseLibSearchPath": "/worse_lib",
  "logsDirectory" : "/bigtmp/log" 
}
EOF

ENTRYPOINT ["python", "main.py"]
CMD ["--help"]