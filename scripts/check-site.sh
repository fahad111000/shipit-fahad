#!/usr/bin/env bash
set -e

SITE_DIR="${1:-site}"

echo "Running site checks on directory: $SITE_DIR"

# Check if directory exists
if [ ! -d "$SITE_DIR" ]; then
    echo "ERROR: Directory $SITE_DIR does not exist!"
    exit 1
fi

# Check for HTML files and basic constraints
for file in "$SITE_DIR"/*.html; do
    if [ -f "$file" ]; then
        echo "Checking $file..."
        if ! grep -q "<title>" "$file"; then
            echo "ERROR: Missing <title> tag in $file"
            exit 1
        fi
    fi
done

echo "All site checks passed successfully!"
