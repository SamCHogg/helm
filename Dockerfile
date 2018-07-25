FROM alpine:latest

ARG helm_version=helm-v2.9.1-linux-amd64
ADD https://storage.googleapis.com/kubernetes-helm/$helm_version.tar.gz /tmp
RUN tar xzvf /tmp/helm-v2.9.1-linux-amd64.tar.gz -C /tmp && cp /tmp/linux-amd64/helm /usr/local/bin/helm

RUN apk --no-cache add python py-pip git make bash && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

RUN helm init --client-only --skip-refresh && helm plugin install https://github.com/hypnoglow/helm-s3.git

ENTRYPOINT ["helm"]
