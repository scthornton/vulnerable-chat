# Security Policy

## ⚠️ Intentional Vulnerabilities

**IMPORTANT:** This application contains **intentional security vulnerabilities** designed for testing, training, and educational purposes.

### Vulnerabilities by Design

The following vulnerabilities are **intentionally included**:

| Vulnerability | OWASP Category | Status |
|---------------|----------------|--------|
| Prompt Injection | LLM01:2025 | Intentional |
| Insecure Output Handling | LLM02:2025 | Intentional |
| Insufficient Input Validation | LLM03:2025 | Intentional |
| Sensitive Information Disclosure | LLM06:2025 | Intentional |
| Jailbreak | Related to LLM01 | Intentional |
| Credential Disclosure | Multiple | Intentional |
| Database Exposure | LLM06:2025 | Intentional |

**DO NOT report these as security issues** - they are the core purpose of this application.

---

## 🔒 Reporting Unintentional Vulnerabilities

If you discover a security vulnerability that is **NOT** part of the intentional design (e.g., in dependencies, Docker configuration, or deployment scripts), please report it responsibly.

### What Qualifies as Unintentional

- Vulnerabilities in dependencies (Flask, OpenAI SDK, etc.)
- Docker container escape possibilities
- Insecure Docker configurations
- Script injection in automation scripts
- Actual credential leakage (not the fake data)
- Build process vulnerabilities

### How to Report

**DO NOT open public GitHub issues for unintentional vulnerabilities.**

Instead:

1. **Email:** security@perfecxion.ai (or repository maintainer email)
2. **Subject:** "SECURITY: Vulnerable-Chat Unintentional Vulnerability"
3. **Include:**
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if known)
   - Your contact information

### Response Timeline

- **Acknowledgment:** Within 48 hours
- **Initial Assessment:** Within 7 days
- **Fix Development:** Based on severity (Critical: 7 days, High: 14 days, Medium: 30 days)
- **Public Disclosure:** After fix is released and users are notified

### Recognition

We will credit security researchers who responsibly disclose unintentional vulnerabilities in:
- CHANGELOG.md
- Security advisories
- Release notes

---

## 🚨 Supported Versions

| Version | Supported          | Status |
| ------- | ------------------ | ------ |
| 1.0.x   | :white_check_mark: | Current |
| < 1.0   | :x:                | Deprecated |

Only the latest version receives security updates for **unintentional** vulnerabilities.

---

## 🛡️ Safe Usage Guidelines

### DO:

✅ Use in isolated test environments
✅ Use on private networks with firewall protection
✅ Use for Prisma AIRS testing and validation
✅ Use for security training and education
✅ Use with test API keys (if using OpenAI mode)
✅ Delete after testing is complete

### DO NOT:

❌ Deploy to production environments
❌ Expose to the public internet
❌ Use with production API keys
❌ Process real customer data
❌ Use as a template for production applications
❌ Leave running unmonitored

---

## 🔐 Dependency Security

We regularly update dependencies to address **unintentional** vulnerabilities:

### Python Dependencies

- Flask - Web framework
- flask-cors - CORS support
- openai - OpenAI API client (optional)
- python-dotenv - Environment configuration

### Monitoring

Run security scans with:

```bash
# Check for known vulnerabilities
pip install safety
safety check -r requirements.txt

# Update dependencies
pip install --upgrade -r requirements.txt
```

### Docker Security

```bash
# Scan Docker image
docker scan vulnerable-ai-chatbot_vulnerable-chatbot

# Update base image
# Edit Dockerfile and change:
# FROM python:3.11-slim
```

---

## 📋 Security Checklist for Deployment

Before deploying for testing:

- [ ] Environment is isolated (not production)
- [ ] Firewall rules restrict access
- [ ] No real customer data present
- [ ] Using test API keys only (if OpenAI mode)
- [ ] Monitoring/logging configured
- [ ] Team understands this is intentionally vulnerable
- [ ] Deletion plan after testing

---

## 🤝 Responsible Disclosure

We follow responsible disclosure practices:

1. **Private Reporting:** Vulnerabilities reported privately first
2. **Coordinated Disclosure:** Fix developed and tested before announcement
3. **User Notification:** All users notified of security updates
4. **Public Disclosure:** Details published after fix is available
5. **Credit:** Researchers credited for responsible disclosure

---

## 📚 Security Resources

### For Intentional Vulnerabilities

These resources explain the vulnerabilities this application demonstrates:

- **OWASP Top 10 for LLMs:** https://owasp.org/www-project-top-10-for-large-language-model-applications/
- **NIST AI Risk Management Framework:** https://www.nist.gov/itl/ai-risk-management-framework
- **Prisma AIRS Documentation:** https://docs.paloaltonetworks.com/ai-runtime-security

### For Safe Deployment

- **Docker Security Best Practices:** https://docs.docker.com/engine/security/
- **Flask Security:** https://flask.palletsprojects.com/en/latest/security/
- **Python Security:** https://python.readthedocs.io/en/stable/library/security_warnings.html

---

## 📞 Contact

**General Questions:** Open a GitHub issue
**Security Reports (unintentional vulnerabilities):** security@perfecxion.ai
**Prisma AIRS Support:** Your Palo Alto Networks account team

---

## ⚖️ Legal

This software is provided "AS IS" for testing and educational purposes. The authors are not responsible for misuse or damages resulting from deployment of this intentionally vulnerable application.

Users are responsible for:
- Securing their test environments
- Protecting sensitive data
- Complying with local laws and regulations
- Obtaining necessary approvals before testing

---

**Last Updated:** January 2026
**Version:** 1.0.0
