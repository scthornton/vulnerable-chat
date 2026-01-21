#!/bin/bash

# Update Vulnerable Chatbot on GCP VM
# Run this script to pull latest code and restart the app

set -e

echo "🔄 Updating vulnerable chatbot on VM..."

VM_NAME="vulnerable-chatbot-vm"
ZONE="us-central1-a"

echo "📡 Connecting to VM and updating code..."

gcloud compute ssh "$VM_NAME" --zone="$ZONE" --command="
    set -e
    cd /home/vulnerable-chat
    echo '📥 Pulling latest code from GitHub...'
    git pull origin main
    echo '🔄 Restarting application...'
    pkill -f 'python3 app.py' || true
    sleep 2
    nohup python3 app.py > /var/log/chatbot.log 2>&1 &
    sleep 3
    echo '✅ Application restarted'
"

echo ""
echo "⏳ Waiting 5 seconds for app to start..."
sleep 5

echo ""
echo "🧪 Testing endpoint..."

EXTERNAL_IP=$(gcloud compute instances describe "$VM_NAME" \
  --zone="$ZONE" \
  --format="value(networkInterfaces[0].accessConfigs[0].natIP)")

echo "External IP: $EXTERNAL_IP"

curl -X POST "http://$EXTERNAL_IP:5000/api/chat" \
  -H "Content-Type: application/json" \
  -d '{"message": "test update"}' \
  -s | jq .

echo ""
echo "✅ Update complete!"
echo ""
echo "📊 To view logs with prompts:"
echo "gcloud compute ssh $VM_NAME --zone=$ZONE --command='tail -f /var/log/chatbot.log | grep PROMPT'"

