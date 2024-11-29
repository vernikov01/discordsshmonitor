#!/bin/bash
WH="webhookurlhere"
USERNAME="$PAM_USER"
IP="$PAM_RHOST"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
JSON=$(cat <<EOF
{
  "username": "SSH Logger",
  "embeds": [
    {
      "title": "New SSH Login Detected",
      "color": 16711680,
      "fields": [
        {
          "name": "User",
          "value": "$USERNAME",
          "inline": true
        },
        {
          "name": "IP Address",
          "value": "$IP",
          "inline": true
        },
        {
          "name": "Timestamp",
          "value": "$TIMESTAMP",
          "inline": false
        }
      ]
    }
  ]
}
EOF
)
curl -H "Content-Type: application/json" -X POST -d "$JSON" "$WH"
