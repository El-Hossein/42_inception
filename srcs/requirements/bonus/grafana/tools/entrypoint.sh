#!/bin/bash
set -e

echo "Starting Grafana..."

exec /usr/sbin/grafana-server \
    --config=/etc/grafana/grafana.ini \
    --homepath=/usr/share/grafana \
    --pidfile=/var/run/grafana/grafana-server.pid \
    cfg:default.paths.logs=/var/log/grafana \
    cfg:default.paths.data=/var/lib/grafana \
    cfg:default.paths.plugins=/var/lib/grafana/plugins \
    cfg:default.paths.provisioning=/etc/grafana/provisioning
