# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-20

### Added
- Initial release
- Flask-based vulnerable AI chatbot application
- Docker containerization with docker-compose
- Two deployment modes: FREE (pattern matching) and PAID (OpenAI API)
- Intentional vulnerabilities:
  - Prompt injection (system prompt override)
  - Sensitive data leakage (SSNs, credit cards, passwords)
  - Jailbreak attempts (role manipulation)
  - Credential disclosure (admin passwords)
  - Database exposure (unauthenticated access)
  - Insufficient input validation
  - Insecure output handling
- Simulated database with fake customer data
- Comprehensive documentation:
  - README.md (15KB complete guide)
  - PRISMA_AIRS_CONFIG.md (step-by-step AIRS setup)
  - QUICK_REFERENCE.md (1-page cheat sheet)
- Automated scripts:
  - quick-start.sh (one-command deployment)
  - test-chatbot.sh (automated test suite)
  - create-distribution.sh (package for distribution)
- API endpoints:
  - GET / (application info)
  - GET /health (health check)
  - POST /api/chat (vulnerable chat endpoint)
  - GET /api/database (insecure database dump)
  - GET /api/test-prompts (sample attack prompts)
  - POST /api/reset (session reset)
- Health checks for Docker and Kubernetes
- CORS support for web integration
- Environment-based configuration (.env)
- Vulnerability tracking in responses
- MIT License
- GitHub Actions CI/CD workflow
- Issue templates (bug report, feature request)
- Contributing guidelines

### Security Notes
- All vulnerabilities are intentional for testing purposes
- Application should never be deployed in production
- Should never be exposed to public internet
- All data is synthetic and safe for testing

### Documentation
- Complete API reference
- Architecture diagrams
- Prisma AIRS integration guide
- Manual testing examples
- Troubleshooting guide
- Network configuration examples
- Cost estimates (FREE vs PAID modes)

### Testing
- 7 automated test cases
- Manual test examples for all vulnerability types
- Expected Prisma AIRS results (50-100+ vulnerabilities)
- OWASP Top 10 LLM mappings
- NIST AI-RMF framework mappings

### Distribution
- Pre-built .tar.gz package (17KB)
- Pre-built .zip package (22KB)
- Customer-ready deployment
- Email template for customer distribution

## [Unreleased]

### Planned
- Web UI for easier demonstration
- Additional LLM provider support (Anthropic, Cohere, etc.)
- More vulnerability types (RAG poisoning, model extraction)
- Real-time dashboard
- PDF export of test results
- Video tutorials

---

## Version History

- **v1.0.0** (2026-01-20) - Initial release
