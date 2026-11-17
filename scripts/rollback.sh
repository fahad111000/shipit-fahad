cat << 'EOF' > scripts/rollback.sh
#!/usr/bin/env bash
set -e

TEAM_DIR="/var/www/fahad"
RELEASES_DIR="$TEAM_DIR/releases"

echo "Checking available releases for rollback..."

# Available releases ki list nikalna
cd "$RELEASES_DIR"
RELEASES=(*/)

if [ "${#RELEASES[@]}" -lt 2 ]; then
    echo "ERROR: Not enough releases to roll back!"
    exit 1
fi

# Second last release ko live banana
PREVIOUS_RELEASE="${RELEASES[-2]}"
PREVIOUS_RELEASE=${PREVIOUS_RELEASE%/}

ln -sfn "$RELEASES_DIR/$PREVIOUS_RELEASE" "$TEAM_DIR/current"
echo "Rolled back to release: $PREVIOUS_RELEASE"
echo "Rolled back to $PREVIOUS_RELEASE" >> "$TEAM_DIR/deploys.log"
EOF
