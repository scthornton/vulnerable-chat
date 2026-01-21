# GitHub Repository Setup Guide

## Step 1: Create GitHub Repository

### Via GitHub Web Interface

1. Go to https://github.com/new
2. Enter repository details:
   - **Repository name:** `vulnerable-chat`
   - **Description:** `Intentionally vulnerable AI chatbot for Prisma AIRS AI Red Teaming testing and security education`
   - **Visibility:** Public (recommended for open source) or Private
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
3. Click **Create repository**

### Repository Settings (Optional but Recommended)

After creating the repository:

1. **Add Topics** (Settings → General):
   - `ai-security`
   - `llm-security`
   - `prisma-airs`
   - `security-testing`
   - `vulnerable-by-design`
   - `owasp-top-10`
   - `docker`
   - `python`
   - `flask`
   - `openai`

2. **Add Description:**
   ```
   🚨 Intentionally Vulnerable AI Chatbot for Prisma AIRS AI Red Teaming Testing

   A Docker-containerized vulnerable chatbot demonstrating OWASP Top 10 LLM
   vulnerabilities including prompt injection, data leakage, and jailbreaks.
   Designed for security testing with Palo Alto Networks Prisma AIRS.

   ⚠️ FOR TESTING ONLY - DO NOT DEPLOY IN PRODUCTION
   ```

3. **Features to Enable** (Settings → General):
   - ✅ Issues
   - ✅ Discussions (optional - good for Q&A)
   - ✅ Projects (optional)
   - ✅ Wiki (optional - additional docs)
   - ❌ Sponsorships (unless you want donations)

4. **Security** (Settings → Security):
   - Enable Dependabot alerts
   - Enable Dependabot security updates
   - Enable Secret scanning (if available)

---

## Step 2: Push Local Repository to GitHub

You have two options:

### Option A: If You Created Repo as "vulnerable-chat" (Recommended)

```bash
cd /home/scott/panw-rag/vulnerable-ai-chatbot

# Add GitHub remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/vulnerable-chat.git

# Push to GitHub
git push -u origin main
```

### Option B: If You Named It Something Else

```bash
cd /home/scott/panw-rag/vulnerable-ai-chatbot

# Add GitHub remote with your actual repo name
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git push -u origin main
```

### If Pushing Fails (Branch Name Issue)

Some repos default to `master` instead of `main`:

```bash
# Check current branch
git branch

# If on master, rename to main
git branch -M main

# Push again
git push -u origin main
```

---

## Step 3: Verify Upload

Visit your repository on GitHub:
```
https://github.com/YOUR_USERNAME/vulnerable-chat
```

You should see:
- ✅ All 14+ files uploaded
- ✅ README.md displayed on home page
- ✅ Proper directory structure (docs/, .github/, etc.)
- ✅ Distribution packages (.tar.gz, .zip)

---

## Step 4: Create Release (Optional but Recommended)

### Via GitHub Web Interface

1. Go to your repo → **Releases** → **Create a new release**
2. Click **Choose a tag** → Type `v1.0.0` → Click **Create new tag**
3. **Release title:** `v1.0.0 - Initial Release`
4. **Description:**

```markdown
## 🎉 Initial Release - Vulnerable AI Chatbot v1.0.0

A production-ready, Docker-containerized vulnerable AI chatbot for testing
Prisma AIRS AI Red Teaming and security education.

### 🎯 What's Included

- **Flask application** with intentional security vulnerabilities
- **Two deployment modes:** FREE (pattern matching) or PAID (OpenAI API)
- **Docker configuration** for one-command deployment
- **Complete documentation** (README, AIRS config, quick reference)
- **Automated scripts** (quick-start, test suite, packager)
- **Distribution packages** ready for customer delivery

### 🚨 Vulnerabilities by Design

- ✅ Prompt Injection (OWASP LLM01:2025)
- ✅ Sensitive Data Leakage (OWASP LLM06:2025)
- ✅ Insecure Output Handling (OWASP LLM02:2025)
- ✅ Jailbreak / Role Manipulation
- ✅ Credential Disclosure
- ✅ Database Exposure

### 📦 Quick Start

```bash
# Download and extract
wget https://github.com/YOUR_USERNAME/vulnerable-chat/releases/download/v1.0.0/vulnerable-ai-chatbot-v1.0.0.tar.gz
tar -xzf vulnerable-ai-chatbot-v1.0.0.tar.gz
cd vulnerable-ai-chatbot-v1.0.0

# One-command deployment
bash quick-start.sh

# Test it works
curl http://localhost:5000/health
```

### 🎯 Prisma AIRS Testing

Expected results when scanning with Prisma AIRS:
- **50-100+ vulnerabilities** detected
- **OWASP Top 10 LLM** mapping
- **NIST AI-RMF** framework alignment
- **30-45 minute** scan duration

### 📚 Documentation

- [README.md](./README.md) - Complete guide
- [PRISMA_AIRS_CONFIG.md](./PRISMA_AIRS_CONFIG.md) - AIRS setup
- [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - Cheat sheet
- [ARCHITECTURE.md](./docs/ARCHITECTURE.md) - Technical details

### ⚠️ Security Warning

This application is **INTENTIONALLY VULNERABLE** for testing purposes.
- ❌ DO NOT deploy in production
- ❌ DO NOT expose to the internet
- ✅ Use only in isolated test environments

### 📝 License

MIT License - Free to use and distribute

---

**What's Next?**
- Share with customers for Prisma AIRS demos
- Use for security training
- Contribute improvements via PRs
```

5. **Upload Assets:** Attach the distribution files:
   - `vulnerable-ai-chatbot-v1.0.0.tar.gz`
   - `vulnerable-ai-chatbot-v1.0.0.zip`

6. Click **Publish release**

### Via Git Command Line

```bash
cd /home/scott/panw-rag/vulnerable-ai-chatbot

# Create and push tag
git tag -a v1.0.0 -m "Initial release v1.0.0"
git push origin v1.0.0

# Then create release via GitHub web interface and attach files
```

---

## Step 5: Add Badges to README (Optional)

Add these badges to the top of your README.md:

```markdown
# Vulnerable AI Chatbot

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Docker](https://img.shields.io/badge/docker-ready-brightgreen.svg)
![Python](https://img.shields.io/badge/python-3.9%2B-blue.svg)
![Security](https://img.shields.io/badge/security-intentionally%20vulnerable-red.svg)
![Prisma AIRS](https://img.shields.io/badge/Prisma%20AIRS-compatible-orange.svg)

**🚨 SECURITY WARNING:** This application contains...
```

Commit and push:
```bash
# Edit README.md to add badges
git add README.md
git commit -m "docs: Add badges to README"
git push
```

---

## Step 6: Set Up GitHub Actions (Already Done)

Your `.github/workflows/docker-build.yml` will automatically:
- Build Docker image on every push
- Run health checks
- Execute test suite
- Report status

View results: Go to your repo → **Actions** tab

---

## Step 7: Configure Branch Protection (Recommended for Team Use)

If working with a team:

1. Go to **Settings** → **Branches**
2. Add rule for `main` branch:
   - ✅ Require pull request before merging
   - ✅ Require status checks to pass (GitHub Actions)
   - ✅ Require conversation resolution before merging
   - ❌ Do not require signed commits (optional)

---

## Step 8: Add Repository Metadata

### Create CODEOWNERS file

```bash
cat > .github/CODEOWNERS << 'EOF'
# Repository owners
* @YOUR_USERNAME

# Documentation
*.md @YOUR_USERNAME
docs/ @YOUR_USERNAME

# Docker configuration
Dockerfile @YOUR_USERNAME
docker-compose.yml @YOUR_USERNAME

# Core application
app.py @YOUR_USERNAME
EOF

git add .github/CODEOWNERS
git commit -m "docs: Add CODEOWNERS file"
git push
```

### Add Funding (Optional)

If you want to accept sponsorships:

```bash
cat > .github/FUNDING.yml << 'EOF'
# GitHub Sponsors
github: YOUR_USERNAME

# Or other platforms
# patreon: YOUR_USERNAME
# ko_fi: YOUR_USERNAME
EOF

git add .github/FUNDING.yml
git commit -m "docs: Add funding options"
git push
```

---

## Step 9: Share Repository

### Get Repository URLs

**HTTPS Clone:**
```
https://github.com/YOUR_USERNAME/vulnerable-chat.git
```

**SSH Clone:**
```
git@github.com:YOUR_USERNAME/vulnerable-chat.git
```

**Distribution Downloads:**
```
https://github.com/YOUR_USERNAME/vulnerable-chat/releases/download/v1.0.0/vulnerable-ai-chatbot-v1.0.0.tar.gz
https://github.com/YOUR_USERNAME/vulnerable-chat/releases/download/v1.0.0/vulnerable-ai-chatbot-v1.0.0.zip
```

### Share with Customers

**Email Template:**

```
Subject: Vulnerable AI Chatbot for Prisma AIRS Testing

Hi Team,

I've published the vulnerable AI chatbot for Prisma AIRS testing on GitHub:

Repository: https://github.com/YOUR_USERNAME/vulnerable-chat

Quick Start:
wget https://github.com/YOUR_USERNAME/vulnerable-chat/releases/download/v1.0.0/vulnerable-ai-chatbot-v1.0.0.tar.gz
tar -xzf vulnerable-ai-chatbot-v1.0.0.tar.gz
cd vulnerable-ai-chatbot-v1.0.0
bash quick-start.sh

Features:
- Zero-cost deployment option (no API key needed)
- Docker containerized (one command to start)
- 50-100+ vulnerabilities for AIRS to detect
- Complete documentation included

All instructions in the README.

Best regards,
[Your Name]
```

### Social Media Announcement

**LinkedIn/Twitter:**

```
🚨 Just released: Vulnerable AI Chatbot v1.0.0

An intentionally insecure chatbot for testing Palo Alto Networks
Prisma AIRS AI Red Teaming.

✅ Docker containerized
✅ Zero-cost deployment option
✅ 50+ OWASP LLM vulnerabilities
✅ Complete documentation

Perfect for security testing, training, and demos.

https://github.com/YOUR_USERNAME/vulnerable-chat

#AISecurityy #LLMSecurity #PrismaAIRS #OWASP #Cybersecurity
```

---

## Step 10: Monitor and Maintain

### Watch for Issues

Enable notifications:
- Settings → Notifications → Custom
- ✅ Issues
- ✅ Pull requests
- ✅ Discussions

### Regular Maintenance

```bash
# Check for dependency updates
cd /home/scott/panw-rag/vulnerable-ai-chatbot
pip list --outdated

# Update requirements.txt if needed
# Test thoroughly
# Commit and push

git add requirements.txt
git commit -m "deps: Update dependencies"
git push
```

### Monitor Stars and Forks

Track adoption:
- **Stars** = People interested
- **Forks** = People customizing
- **Issues** = People using it

---

## Troubleshooting

### Problem: Push rejected (authentication failed)

**Solution:** Set up Git credentials

```bash
# Option A: HTTPS with personal access token
git remote set-url origin https://YOUR_TOKEN@github.com/YOUR_USERNAME/vulnerable-chat.git

# Option B: SSH (recommended)
git remote set-url origin git@github.com:YOUR_USERNAME/vulnerable-chat.git
```

### Problem: Files too large

**Solution:** Git LFS for large files (if needed)

```bash
git lfs install
git lfs track "*.tar.gz"
git lfs track "*.zip"
git add .gitattributes
git commit -m "Add Git LFS tracking"
git push
```

### Problem: Wrong branch name

**Solution:** Rename branch

```bash
git branch -M main
git push -u origin main
```

---

## Complete Command Reference

```bash
# Initial setup
cd /home/scott/panw-rag/vulnerable-ai-chatbot
git init
git add -A
git commit -m "Initial commit: Vulnerable AI Chatbot v1.0.0"

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/vulnerable-chat.git
git push -u origin main

# Create release tag
git tag -a v1.0.0 -m "Initial release v1.0.0"
git push origin v1.0.0

# Future updates
git add .
git commit -m "Your commit message"
git push

# Create new release
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin v1.1.0
```

---

## Success Checklist

- [ ] GitHub repository created named `vulnerable-chat`
- [ ] All files pushed successfully
- [ ] README.md displays properly on repo home page
- [ ] GitHub Actions workflow runs successfully
- [ ] v1.0.0 release created
- [ ] Distribution files attached to release
- [ ] Topics/tags added to repository
- [ ] Repository description set
- [ ] Security features enabled (Dependabot, etc.)
- [ ] CODEOWNERS file added
- [ ] README badges added (optional)
- [ ] Branch protection configured (optional)
- [ ] Repository shared with team/customers

---

## Need Help?

**GitHub Documentation:**
- Creating repositories: https://docs.github.com/en/repositories/creating-and-managing-repositories
- Creating releases: https://docs.github.com/en/repositories/releasing-projects-on-github
- GitHub Actions: https://docs.github.com/en/actions

**Git Commands:**
- Git reference: https://git-scm.com/docs
- Git workflows: https://www.atlassian.com/git/tutorials

---

**You're ready to publish!** 🚀

After following these steps, you'll have a professional, well-documented
GitHub repository ready to share with customers and the security community.
