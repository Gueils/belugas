![belugas](belugas.png)

## Overview

`belugas` is a command line interface for the Belugas feature detection analysis
platform. It allows you to run feature detector engines on your local machine inside
of Docker containers. It is based on [codeclimate cli](https://github.com/codeclimate/codeclimate)

## Prerequisites

The Belugas CLI is distributed and run as a [Docker](https://www.docker.com) image. The engines that
perform the actual analyses are also Docker images. To support this, you must have Docker installed
and running locally. We also require that the Docker daemon supports connections
on the default Unix socket `/var/run/docker.sock`.

## Installation

```console
docker pull icalialabs/belugas:latest
```

## Usage

### 1: Standard (Non-development)
```console
docker run \
  --interactive --tty --rm \
  --env BELUGAS_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/fdet:/tmp/fdet \
  icalialabs/belugas analyze . -f json
```

### 2: Development:

Copy the `example.env` file to `.env`, and edit it so the `BELUGAS_CODE` points to a folder in your
host. Then:

```
plis run app belugas analyze . -f json
```

## Copyright

See [LICENSE](LICENSE)
