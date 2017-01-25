FROM elasticio/cedarish:jdk8_experimental

ADD ./runner/ /runner
#ADD ./bin/sdutil /bin/sdutil

ENTRYPOINT ["/runner/init"]
