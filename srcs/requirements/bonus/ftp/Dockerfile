FROM debian:bookworm

RUN apt-get update && apt-get install -y  vsftpd

RUN  rm -rf /var/lib/apt/lists/*
COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 21 40000-40005

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]