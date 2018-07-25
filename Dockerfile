FROM alpine:3.7

ARG helm_version=helm-v2.9.1-linux-amd64
ARG k8s_version=v1.11.1

ADD https://storage.googleapis.com/kubernetes-helm/$helm_version.tar.gz /tmp
RUN tar xzvf /tmp/helm-v2.9.1-linux-amd64.tar.gz -C /tmp && cp /tmp/linux-amd64/helm /usr/local/bin/helm

RUN apk --no-cache add python py-pip git make bash && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

ADD https://storage.googleapis.com/kubernetes-release/release/$k8s_version/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN helm init --client-only --skip-refresh && helm plugin install https://github.com/hypnoglow/helm-s3.git

ENTRYPOINT ["helm"]
