# GCP VM Deployment Guide - For Customers with Authentication Restrictions

## Problem This Solves

If you encounter authentication issues deploying to Google Cloud Run (401 Unauthorized errors), this guide shows how to deploy to a Compute Engine VM with **no authentication required** - ideal for Prisma AIRS testing.

---

## Quick Deployment (3 Minutes)

### Step 1: Create Startup Script

Save this as `startup-script.sh`:

```bash
#!/bin/bash
apt-get update
apt-get install -y python3-pip git
pip3 install --break-system-packages Flask==3.0.0 flask-cors==4.0.0 python-dotenv==1.0.0
cd /home
git clone https://github.com/scthornton/vulnerable-chat.git
cd vulnerable-chat
export USE_OPENAI=false
nohup python3 app.py > /var/log/chatbot.log 2>&1 &
```

### Step 2: Create VM

```bash
gcloud compute instances create vulnerable-chatbot-vm \
  --zone=us-central1-a \
  --machine-type=e2-micro \
  --tags=http-server \
  --image-family=debian-12 \
  --image-project=debian-cloud \
  --metadata-from-file=startup-script=startup-script.sh
```

### Step 3: Create Firewall Rule

```bash
gcloud compute firewall-rules create allow-chatbot-5000 \
  --allow=tcp:5000 \
  --target-tags=http-server \
  --source-ranges=0.0.0.0/0
```

### Step 4: Get External IP

```bash
gcloud compute instances describe vulnerable-chatbot-vm \
  --zone=us-central1-a \
  --format="value(networkInterfaces[0].accessConfigs[0].natIP)"
```

### Step 5: Wait 2 Minutes

The startup script installs dependencies and starts the app. After 2 minutes, test:

```bash
curl http://YOUR_EXTERNAL_IP:5000/health
```

Expected:
```json
{"status":"healthy","timestamp":"2026-01-21T..."}
```

---

## Prisma AIRS Configuration

Use this cURL for import:

```bash
curl -X POST http://YOUR_EXTERNAL_IP:5000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "{INPUT}"}'
```

**In Prisma AIRS:**
1. Go to: Prisma AIRS → AI Red Teaming → Targets
2. Click: "+ Add Target"
3. Select: "Import from cURL"
4. Paste the cURL command above (replace YOUR_EXTERNAL_IP)
5. Click: "Test Connection" → Should return HTTP 200
6. Save and create scan

---

## Cost Estimate

- **VM:** e2-micro (~$7/month, free tier eligible)
- **Network egress:** ~$1-3/month for testing
- **Total:** ~$8-10/month (or free with GCP free tier)

---

## Advantages Over Cloud Run

| Feature | VM Deployment | Cloud Run |
|---------|---------------|-----------|
| Authentication | None required | Requires Bearer tokens |
| Token expiration | N/A | Expires after 1 hour |
| Org policies | Not affected | May block public access |
| Prisma AIRS compatibility | ✅ Works immediately | ❌ May fail with 401 |
| Setup complexity | Moderate | Simple (when it works) |
| Cost | ~$7/month | Free tier + requests |

---

## Cleanup

When done testing:

```bash
# Delete VM
gcloud compute instances delete vulnerable-chatbot-vm --zone=us-central1-a

# Delete firewall rule
gcloud compute firewall-rules delete allow-chatbot-5000
```

---

## Troubleshooting

### Issue: Can't connect to port 5000

**Check firewall rule:**
```bash
gcloud compute firewall-rules list --filter="name=allow-chatbot-5000"
```

**Check if app is running:**
```bash
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a \
  --command="ps aux | grep 'python3 app.py'"
```

### Issue: Startup script didn't run

**View startup logs:**
```bash
gcloud compute instances get-serial-port-output vulnerable-chatbot-vm \
  --zone=us-central1-a | grep startup-script
```

### Issue: App crashed

**Check app logs:**
```bash
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a \
  --command="cat /var/log/chatbot.log"
```

### Fix: Restart the app

```bash
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a \
  --command="cd /home/vulnerable-chat && nohup python3 app.py > /var/log/chatbot.log 2>&1 &"
```

---

## Alternative: Docker Deployment

If you prefer Docker:

```bash
# Create VM with Container-Optimized OS
gcloud compute instances create vulnerable-chatbot-vm \
  --zone=us-central1-a \
  --machine-type=e2-small \
  --tags=http-server \
  --image-family=cos-stable \
  --image-project=cos-cloud

# SSH and run container
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a

# On the VM:
docker run -d -p 5000:5000 --restart=always \
  -e USE_OPENAI=false \
  ghcr.io/YOUR_USERNAME/vulnerable-chatbot:latest
```

---

## Security Notes

⚠️ **This deployment is intentionally insecure for testing:**
- Open to public internet
- No authentication
- Contains intentional vulnerabilities

✅ **DO:**
- Use only for Prisma AIRS testing
- Delete after testing
- Monitor for unexpected traffic

❌ **DO NOT:**
- Use in production
- Deploy with real customer data
- Leave running indefinitely

---

## Expected Prisma AIRS Results

When scanning this endpoint with Prisma AIRS:
- **Vulnerabilities detected:** 50-100+
- **OWASP categories:** LLM01, LLM02, LLM06
- **Scan duration:** 30-45 minutes
- **Severity distribution:** Critical (40%), High (30%), Medium/Low (30%)

---

## Support

**For GCP issues:**
- [Compute Engine Documentation](https://cloud.google.com/compute/docs)
- [Firewall Rules Guide](https://cloud.google.com/firewall/docs/firewalls)

**For Prisma AIRS issues:**
- [Prisma AIRS Targets Documentation](https://docs.paloaltonetworks.com/ai-runtime-security/ai-red-teaming)

---

**Last Updated:** 2026-01-21  
**Tested On:** Debian 12, GCP us-central1-a
