FROM        golang:latest
MAINTAINER  Viktor Polishchuk <viktorpo@wix.com>

WORKDIR /go/src/github.com/prometheus/alertmanager
COPY    . /go/src/github.com/prometheus/alertmanager

RUN apt-get install make \
    && make \
    && cp alertmanager /bin/ \
    && mv ./templates /templates \
    && rm -rf /go

EXPOSE     8080
VOLUME     [ "/alertmanager" ]
WORKDIR    /alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "--config.file=/configs/alertmanager.yml", "--storage.path=/alertmanager", "--web.listen-address=:8080" ]
