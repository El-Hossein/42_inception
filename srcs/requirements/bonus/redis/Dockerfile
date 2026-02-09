FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y redis-server

RUN  rm -rf /var/lib/apt/lists/*

RUN sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf

ENTRYPOINT ["redis-server", "--protected-mode", "no"]
