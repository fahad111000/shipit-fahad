#!/bin/bash

# Output file path (jahan live site deploy hoti hai)
OUTPUT_FILE="/var/www/fahad/current/status.html"

# Server ki details nikalna
DATE=$(date)
UPTIME=$(uptime -p)
DISK=$(df -h / | awk 'NR==2 {print $5 " used out of " $2}')
MEMORY=$(free -m | awk 'NR==2 {printf "%.2f%%", $3*100/$2 }')
REQUESTS=$(sudo wc -l < /var/log/nginx/access.log 2>/dev/null || echo "0")

# HTML Status Page generate karna
cat <<EOF > $OUTPUT_FILE
<!DOCTYPE html>
<html>
<head>
    <title>Server Status</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f4f4f9; }
        .card { background: white; padding: 20px; border-radius: 8px; max-width: 500px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { color: #2c3e50; }
        p { font-size: 16px; margin: 10px 0; }
    </style>
</head>
<body>
    <div class="card">
        <h2>🚀 Live Server Status</h2>
        <p><strong>Last Updated:</strong> $DATE</p>
        <p><strong>Server Uptime:</strong> $UPTIME</p>
        <p><strong>Disk Usage:</strong> $DISK</p>
        <p><strong>Memory Usage:</strong> $MEMORY</p>
        <p><strong>Total Nginx Requests:</strong> $REQUESTS</p>
    </div>
</body>
</html>
EOF

echo "Status page successfully updated!"