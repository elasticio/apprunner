FROM elasticio/cedarish

ADD ./runner/ /runner
#ADD ./bin/sdutil /bin/sdutil

ENTRYPOINT ["/runner/init"]
