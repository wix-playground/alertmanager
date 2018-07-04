FROM        prom/busybox:latest
MAINTAINER  Viktor Polishchuk <viktorpo@wix.com>

RUN apt-get update
RUN apt-get -y install make
RUN apt-get -y install golang
RUN make build

COPY amtool                       /bin/amtool
COPY alertmanager                 /bin/alertmanager
COPY config/alertmanager.yml      /etc/alertmanager/alertmanager.yml
COPY config/*.tmpl                /etc/alertmanager

EXPOSE     8080
VOLUME     [ "/alertmanager" ]
WORKDIR    /etc/alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "--storage.path=/alertmanager", "--web.listen-address=:8080" ]
