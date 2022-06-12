FROM arm64v8/node:16
ENV BOS_DEFAULT_SAVED_NODE=embassy
ADD . /
RUN cd balanceofsatoshis && npm i -g balanceofsatoshis

RUN apt-get update && \
    apt-get install -y screen

WORKDIR /usr/local/lib/
RUN npm install --global wetty

WORKDIR /

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
ADD assets/motd /etc/motd
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
ADD assets/utils/check-web.sh /usr/local/bin/check-web.sh
RUN chmod +x /usr/local/bin/check-web.sh

WORKDIR /balanceofsatoshis/

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
