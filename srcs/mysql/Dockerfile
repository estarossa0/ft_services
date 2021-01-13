FROM	alpine

ARG URLIP

ENV KUBEIP=${URLIP}

RUN mkdir /srcs

COPY ./srcs/ /srcs/

WORKDIR /srcs

VOLUME [ "/sys/fs/cgroup" ]

RUN sh init.sh

RUN ["chmod", "+x", "/srcs/entry.sh"]

ENTRYPOINT [ "/srcs/entry.sh" ]


EXPOSE 3306