#!/usr/bin/env bash
set -e

service rsyslog restart
service ssh restart
dnsmasq -k 