FROM        ubuntu:latest
MAINTAINER  Viktor Polishchuk <viktorpo@wix.com>

RUN apt-get update
RUN apt-get -y install make
RUN apt-get -y install golang

COPY * /opt/go/src/alertmanager/

RUN GOPATH=/opt/go make /opt/go/src/alertmanager

COPY /opt/go/src/alertmanager/amtool                       /bin/amtool
COPY /opt/go/src/alertmanager/alertmanager                 /bin/alertmanager
COPY /opt/go/src/alertmanager/config/alertmanager.yml      /etc/alertmanager/alertmanager.yml
COPY /opt/go/src/alertmanager/config/*.tmpl                /etc/alertmanager

EXPOSE     8080
VOLUME     [ "/alertmanager" ]
WORKDIR    /etc/alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "--storage.path=/alertmanager", "--web.listen-address=:8080" ]
