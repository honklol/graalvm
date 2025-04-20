FROM ghcr.io/graalvm/jdk-community:21

# just in case
RUN microdnf install -y bash curl && microdnf clean all
RUN useradd -m -d /home/container container

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# best practice
ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod 755 /usr/bin/tini

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]