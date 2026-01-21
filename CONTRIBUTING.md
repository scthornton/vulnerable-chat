# Contributing to Vulnerable AI Chatbot

Thank you for considering contributing to this project! This is an intentionally vulnerable application designed for security testing and education.

## Code of Conduct

- Be respectful and professional
- Focus on improving security education
- Never use this code maliciously
- Report security concerns responsibly

## How to Contribute

### Reporting Bugs

1. Check existing issues first
2. Use the bug report template
3. Include clear reproduction steps
4. Provide logs and environment details

### Suggesting Enhancements

1. Open a feature request issue
2. Explain the use case
3. Describe the expected behavior
4. Consider backward compatibility

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly:
   ```bash
   docker-compose build
   docker-compose up -d
   bash test-chatbot.sh
   ```
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request

## Development Guidelines

### Adding New Vulnerabilities

When adding new intentional vulnerabilities:

1. **Document the vulnerability** in code comments
2. **Add test cases** in `test-chatbot.sh`
3. **Update README.md** with the new vulnerability type
4. **Update OWASP mapping** if applicable
5. **Ensure it's detectable** by Prisma AIRS

Example:
```python
# VULNERABILITY: SQL Injection Simulation
if "SELECT" in message_lower or "DROP TABLE" in message_lower:
    vulnerabilities_triggered.append("sql_injection")
    bot_response += "\n[SQL Query Executed]"
```

### Code Style

- Use clear, descriptive variable names
- Add comments explaining vulnerability mechanics
- Keep functions focused and readable
- Follow PEP 8 for Python code

### Testing

Before submitting a PR:

```bash
# Build and start
docker-compose up -d

# Run test suite
bash test-chatbot.sh

# Test Prisma AIRS integration (if available)
# - Configure target in AIRS
# - Run comprehensive scan
# - Verify expected vulnerabilities are found

# Check logs
docker-compose logs

# Cleanup
docker-compose down
```

### Documentation

- Update README.md for new features
- Update PRISMA_AIRS_CONFIG.md for AIRS-specific changes
- Update QUICK_REFERENCE.md for command changes
- Add code comments for complex logic

## Vulnerability Disclosure

If you discover an **unintentional** security vulnerability (e.g., in dependencies or Docker configuration):

1. **DO NOT** open a public issue
2. Email the maintainers privately
3. Allow time for a fix before public disclosure
4. We'll credit you in the release notes

## Ideas for Contributions

### New Vulnerabilities
- Model extraction attacks
- Context confusion attacks
- Multi-step jailbreaks
- RAG poisoning simulation

### New Features
- Web UI for easier demo
- More LLM provider integrations (Anthropic, Cohere)
- Real-time vulnerability dashboard
- Export test results to PDF

### Documentation
- Video tutorials
- More integration examples
- Troubleshooting scenarios
- Best practices guide

### Testing
- Automated Prisma AIRS validation
- Performance benchmarks
- Cross-platform testing (Windows, macOS, Linux)

## Release Process

1. Update version in all files
2. Update CHANGELOG.md
3. Create git tag
4. Build distribution packages
5. Update release notes
6. Notify users

## Questions?

Open a discussion issue or reach out to maintainers.

---

**Remember:** This is an intentionally vulnerable application for testing only. Never deploy in production or expose to the internet.
