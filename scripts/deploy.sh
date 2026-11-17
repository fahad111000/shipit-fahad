#!/usr/bin/env bash
set -e

TEAM_DIR="/var/www/fahad"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
COMMIT_HASH="${1:-latest}"
AUTHOR="${2:-unknown}"

echo "Starting deployment for commit $COMMIT_HASH by $AUTHOR..."

# 1. New release folder banana
RELEASE_DIR="$TEAM_DIR/releases/$TIMESTAMP-$COMMIT_HASH"
mkdir -p "$RELEASE_DIR"

# 2. Uploaded site files ko release folder mein copy karna
cp -r upload/* "$RELEASE_DIR/"

# 3. Footer mein version/commit replace karna (__VERSION__)
find "$RELEASE_DIR" -name "*.html" -exec sed -i "s/__VERSION__/Commit: $COMMIT_HASH by $AUTHOR at $TIMESTAMP/g" {} +

# 4. Current symlink ko naye release ki taraf point karna
ln -sfn "$RELEASE_DIR" "$TEAM_DIR/current"

# 5. deploys.log mein entry likhna
echo "Deployed commit $COMMIT_HASH by $AUTHOR at $TIMESTAMP" >> "$TEAM_DIR/deploys.log"

# 6. Sirf 5 newest releases rakhna, baqi purani delete karna
cd "$TEAM_DIR/releases"
ls -t | tail -n +6 | xargs -I {} rm -rf {}

echo "Deployment completed successfully!"
