FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    prosody \
    lua-event \
    lua-dbi-postgresql \
    lua-sec \
    mercurial \
    ca-certificates \
    openssl \
    git

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/prosody

RUN chown -R prosody:prosody /opt
RUN chown -R prosody:prosody /etc/prosody
RUN chown -R prosody:prosody /var/run/prosody

USER prosody

RUN cd /opt && hg clone https://hg.prosody.im/prosody-modules/ prosody-modules
RUN cd /etc/prosody/certs/ && \
    openssl dhparam -out dh-2048.pem 2048 && \
    chmod u=rw,go= dh-2048.pem

RUN mkdir /etc/prosody/register-templates/ && \
    cd /etc/prosody/register-templates && \
    git clone https://gitlab.com/mimi89999/Prosody-Web-Registration-Theme.git

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua

CMD prosody