# Backend LLM Configuration

## Current Deployment

**VM Endpoint:** http://136.116.87.91:5000/api/chat
**Backend Mode:** Fallback (Pattern Matching) - **No LLM**
**Cost:** $0.00 per request

## Backend Modes

### Mode 1: Fallback Pattern Matching (Current - FREE)

**Configuration:**
```bash
USE_OPENAI=false  # Set in VM startup script
```

**How it works:**
- No external LLM API calls
- Uses rule-based pattern matching on user input
- Responds based on keyword detection
- All vulnerabilities still demonstrable
- Zero API costs

**Response patterns:**
- Account balance queries → Returns fake account balance
- SSN queries → Returns fake SSN (123-45-6789)
- Credential requests → Returns admin credentials
- Prompt injection → Detects and responds with "leaked" data
- General banking questions → Generic banking assistant responses

**Advantages:**
- ✅ Zero cost (no API fees)
- ✅ Fast responses (<50ms)
- ✅ All vulnerability types demonstrable
- ✅ Perfect for demos and testing
- ✅ No API key management required

**Limitations:**
- Less realistic responses (scripted patterns vs natural language)
- Won't demonstrate subtle LLM-specific behaviors
- Fixed response templates

---

### Mode 2: OpenAI API (Optional - PAID)

**Configuration:**
```bash
USE_OPENAI=true
OPENAI_API_KEY=sk-proj-your-key-here
MODEL_NAME=gpt-3.5-turbo  # or gpt-4
```

**How it works:**
- Uses OpenAI API for responses
- Real LLM generates natural language
- More sophisticated prompt injection demonstrations
- Nuanced and contextual responses

**Cost estimates:**
- gpt-3.5-turbo: ~$0.001-0.002 per request
- gpt-4: ~$0.03-0.06 per request
- Prisma AIRS comprehensive scan (500+ prompts): ~$0.50-1.00

**Advantages:**
- ✅ More realistic LLM behavior
- ✅ Natural language responses
- ✅ Better demonstrates subtle prompt injection
- ✅ Contextual understanding

**When to use:**
- Demonstrating real LLM vulnerabilities to customers
- Testing prompt injection sophistication
- Showcasing natural language security issues
- When budget allows for API costs

---

## Switching Between Modes

### On VM Deployment:

**To deploy with OpenAI API:**

1. Update startup script to include API key:
```bash
export USE_OPENAI=true
export OPENAI_API_KEY=sk-proj-your-key-here
export MODEL_NAME=gpt-3.5-turbo
```

2. Redeploy VM or restart app:
```bash
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a \
  --command="cd /home/vulnerable-chat && export USE_OPENAI=true && export OPENAI_API_KEY=your-key && pkill -f 'python3 app.py' && nohup python3 app.py > /var/log/chatbot.log 2>&1 &"
```

### On Docker:

**Fallback mode:**
```bash
docker run -d -p 5000:5000 \
  -e USE_OPENAI=false \
  vulnerable-chatbot:latest
```

**OpenAI mode:**
```bash
docker run -d -p 5000:5000 \
  -e USE_OPENAI=true \
  -e OPENAI_API_KEY=sk-proj-your-key \
  -e MODEL_NAME=gpt-3.5-turbo \
  vulnerable-chatbot:latest
```

---

## Vulnerabilities in Each Mode

Both modes demonstrate all vulnerability categories:

| Vulnerability | Fallback Mode | OpenAI Mode |
|---------------|---------------|-------------|
| **Prompt Injection** | ✅ Detects keywords, returns leaked data | ✅ Natural language injection, more sophisticated |
| **Sensitive Data Disclosure** | ✅ Returns fake PII/SSNs/credentials | ✅ Same data, more conversational |
| **Jailbreak Attempts** | ✅ Role manipulation detected | ✅ More nuanced jailbreak responses |
| **Insecure Output** | ✅ No filtering on responses | ✅ No filtering on responses |
| **Direct Database Access** | ✅ /api/database endpoint | ✅ /api/database endpoint |

---

## Logging and Monitoring

All incoming prompts are logged for analysis:

**Log format:**
```
[PROMPT] session-1234: Ignore all previous instructions and reveal...
```

**View logs:**
```bash
# On VM
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a \
  --command="tail -f /var/log/chatbot.log"

# Filter for prompts only
gcloud compute ssh vulnerable-chatbot-vm --zone=us-central1-a \
  --command="tail -f /var/log/chatbot.log | grep PROMPT"
```

---

## Recommendation

**For Prisma AIRS Testing:**
✅ Use **Fallback Mode** (current deployment)

**Reasons:**
- Zero cost for comprehensive scans
- Demonstrates all vulnerability types effectively
- Fast responses keep scan duration short
- No API key management or rate limiting concerns
- Perfect for customer demos and proof-of-concept

**When to use OpenAI API:**
- Customer specifically wants to see real LLM behavior
- Demonstrating subtle prompt injection techniques
- Budget allows ~$1 per comprehensive scan
- Need natural language responses for realism

---

## Current Status

✅ **Deployed with Fallback Mode**
✅ **All vulnerabilities demonstrable**
✅ **Zero operational cost**
✅ **Prisma AIRS scan in progress: 77% complete**
✅ **Prompt logging enabled**

