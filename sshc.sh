#!/bin/bash
WH="webhookurl"
#live reading of commands being executed
ausearch -k ssh_commands --format raw | while read -r LINE; do
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  COMMAND=$(echo "$LINE" | grep -oP 'exe="[^"]+"' | sed 's/exe="//' | sed 's/"//')
  USER=$(echo "$LINE" | grep -oP 'auid=[0-9]+' | sed 's/auid=//')
  IP=$(echo "$LINE" | grep -oP 'addr=[^ ]+' | sed 's/addr=//')

  # format for sending through discord webhook
  JSON=$(cat <<EOF
{
  "username": "SSH Command Logger",
  "embeds": [
    {
      "title": "SSH Command Executed",
      "color": 16711680,
      "fields": [
        {
          "name": "Command",
          "value": "$COMMAND",
          "inline": false
        },
        {
          "name": "User",
          "value": "$USER",
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
done
