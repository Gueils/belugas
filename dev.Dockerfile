# 1: Use ruby 2.3.3 as base:
FROM ruby:2.3.3

# 2: We'll set this app path as the working directory
WORKDIR /usr/src/app

# 3: We'll set the working dir as HOME and add the app's binaries path to $PATH:
ENV HOME=/usr/src/app PATH=/usr/src/app/bin:$PATH

# 4: Install docker - we'll just need the client to run the codeclimate cli
# containers using the host engine, by mounting the host docker service's socket.
#
# Ripped off from https://hub.docker.com/_/docker Dockerfiles:
RUN set -ex \
  && export DOCKER_BUCKET=get.docker.com \
  && export DOCKER_VERSION=1.12.5 \
  && export DOCKER_SHA256=0058867ac46a1eba283e2441b1bb5455df846144f9d9ba079e97655399d4a2c6 \
  && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz

# 5: Set the default command:
CMD ["guard"]
