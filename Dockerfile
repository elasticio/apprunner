FROM elasticio/cedarish:production
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini



ADD ./runner/ /runner
#ADD ./bin/sdutil /bin/sdutil

ENTRYPOINT ["/tini", "-v", "--", "/runner/init"]
