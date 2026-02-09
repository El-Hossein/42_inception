FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    wget \
    apt-transport-https \
    software-properties-common \
    gnupg \
    procps \
    curl \
    lsb-release \
    ca-certificates

# echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list && \
RUN wget https://dl.grafana.com/oss/release/grafana_10.0.0_amd64.deb && \
    dpkg -i grafana_10.0.0_amd64.deb || apt-get install -f -y && \
    rm -rf grafana_10.0.0_amd64.deb /var/lib/apt/lists/*


RUN mkdir -p /var/lib/grafana /var/log/grafana /var/run/grafana && \
    chmod -R 777 /var/lib/grafana /var/log/grafana /var/run/grafana /etc/grafana

COPY ./conf/grafana.ini /etc/grafana/grafana.ini
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000

# Run as root (default)
ENTRYPOINT ["/entrypoint.sh"]
