#!/bin/sh
set -e

echo "[Suricata] enabling all free sources..."
/usr/bin/suricata-update list-sources --free | /usr/bin/sed 's/\x1b\[[0-9;]*m//g' | /usr/bin/grep Name: | /usr/bin/cut -d' ' -f2 | /usr/bin/xargs -I src /usr/bin/suricata-update enable-source src

echo "[Suricata] Updating rule sources..."
/usr/bin/suricata-update update

echo "[Suricata] Starting Suricata..."
exec /usr/bin/suricata --user suricata --group suricata "$@"
