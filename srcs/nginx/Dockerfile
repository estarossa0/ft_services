FROM	alpine

ARG URLIP
ARG EXTIP

ENV KUBEIP=${URLIP}
ENV EXTERNALIP=${EXTIP}

RUN mkdir /srcs

COPY ./srcs/* /srcs/

WORKDIR /srcs

VOLUME [ "/sys/fs/cgroup" ]

RUN sh init.sh

RUN ["chmod", "+x", "/srcs/entry.sh"]

ENTRYPOINT [ "/srcs/entry.sh" ]


EXPOSE 80 443 22