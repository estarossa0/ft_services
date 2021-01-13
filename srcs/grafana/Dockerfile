FROM	alpine
ARG URLIP

ENV KUBEIP=${URLIP}

RUN mkdir -p /srcs/dashboards

COPY ./srcs/ /srcs/
COPY ./srcs/dashboards/ /srcs/dashboards/
WORKDIR /srcs

VOLUME [ "/sys/fs/cgroup" ]

RUN sh init.sh

RUN ["chmod", "+x", "/srcs/entry.sh"]

ENTRYPOINT [ "/srcs/entry.sh" ]

EXPOSE 3000