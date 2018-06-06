FROM alpine:3.7

ENV ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download"
ENV ALPINE_GLIBC_PACKAGE_VERSION="2.27-r0"
ENV ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk"
ENV ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk"

RUN apk add --no-cache curl=7.60.0-r1 && \
	apk add --no-cache openjdk8-jre-base=8.151.12-r0 && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community tini=0.18.0-r0 && \
	curl -s -L -o "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" && \
	curl -s -L -o "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" && \
	apk add --no-cache --allow-untrusted "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" && \
	apk add --no-cache --allow-untrusted "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" && \
	rm "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME"

COPY bin/run.sh /run.sh
ENTRYPOINT ["/sbin/tini", "-v", "-e", "143", "--", "/run.sh"]
