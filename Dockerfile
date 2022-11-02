FROM ubuntu:20.04

ARG ARCH=x64
ARG RUNNER_VERSION=2.298.2

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y apt-transport-https gnupg2 curl nodejs \
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && curl -s https://baltocdn.com/helm/signing.asc | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list \
    && echo "deb https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm.list \
    && apt-get update \
    && apt-get install kubectl helm \
    && rm -rf /var/lib/apt/lists/*

RUN set -vx; \
    mkdir -p /runner \
    && cd /runner \
    && curl -f -L -o runner.tar.gz https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./runner.tar.gz \
    && rm runner.tar.gz \
    && ./bin/installdependencies.sh \
    && adduser --disabled-password --gecos "" --uid 1000 runner \
    && groupadd docker \
    && usermod -aG sudo runner \
    && usermod -aG docker runner \
    && chown runner:runner -R /runner \
    && rm -rf /var/lib/apt/lists/*

COPY cluster_conf.sh /

USER runner

CMD [ "/runner/run.sh" ]