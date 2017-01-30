FROM elasticio/cedarish:production

ADD ./runner/ /runner
#ADD ./bin/sdutil /bin/sdutil

ENTRYPOINT ["/runner/init"]
