FROM python:alpine

ARG CLI_VERSION=1.16.110

RUN apk -uv add --no-cache groff jq less git bash openssh && \
    pip install --no-cache-dir awscli==$CLI_VERSION

ADD ecs-cf-deploy /usr/local/bin/
ADD deploy-ecs /usr/local/bin/
ADD mycs-functions /usr/local/bin/

CMD sh
