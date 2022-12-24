import docker
from docker.types import Mount



if __name__ == "__main__":
    client = docker.from_env()
    print(client.containers.run("python:3.10.5-bullseye", "echo hello world"))