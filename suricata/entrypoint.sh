#!/bin/sh
set -e

SURICATA_UPDATE="/usr/bin/suricata-update"
SURICATA_LOGDIR="/var/log/suricata"
SURICATA_RULEDIR="/var/lib/suricata"

if [ "$SURICATA_RULES_SOURCES" = "all" ]; then
	echo "[ELK-Suri] SURICATA_RULES_SOURCES is set to 'all'. Enabling all free sources."
	$SURICATA_UPDATE list-sources --free | \
	/usr/bin/sed 's/\x1b\[[0-9;]*m//g' | \
	/usr/bin/grep 'Name:' | \
	/usr/bin/cut -d' ' -f2 | \
	/usr/bin/xargs -I src /usr/bin/suricata-update enable-source src
elif [ -n "$SURICATA_RULES_SOURCES" ]; then
	echo "[ELK-Suri] Enabling requested sources: $SURICATA_RULES_SOURCES"

	# Split the space-separated list of sources and enable each one
	for source in $SURICATA_RULES_SOURCES; do
		$SURICATA_UPDATE enable-source "$source"
	done
else
	echo "[ELK-Suri] SURICATA_RULES_SOURCES is not set. Using default sources (typically ET/open)."
		$SURICATA_UPDATE enable-source "et/open"
fi

echo "[ELK-Suri] Updating rule sources..."
$SURICATA_UPDATE update

echo "[ELK-Suri] Changing permissions on logs and rules..."
/usr/bin/chown -R suricata:suricata $SURICATA_LOGDIR
/usr/bin/chown -R root:suricata $SURICATA_RULEDIR

echo "[ELK-Suri] Starting Suricata..."
exec /usr/bin/suricata --user suricata --group suricata "$@"
