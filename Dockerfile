FROM python:alpine

ARG CLI_VERSION=1.16.110

RUN apk -uv add --no-cache groff jq less && \
    pip install --no-cache-dir awscli==$CLI_VERSION

ADD ecs-cf-deploy /usr/local/bin/

CMD ["ecs-cf-deploy"]