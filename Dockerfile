FROM debian:stretch-slim

### Installing pre-requisites
RUN apt-get update && \
	mkdir -p /usr/share/man/man1 && \
	apt-get install -y --no-install-recommends curl openjdk-8-jre-headless && \
	rm -rf /var/lib/apt/lists/*

### Installing Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY bin/run.sh /run.sh
ENTRYPOINT ["/tini", "-v", "-e", "143", "--", "/run.sh"]
