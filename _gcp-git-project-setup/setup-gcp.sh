#!/bin/bash
# GitHub Repository Setup Script for GCP Dev Platform
# Run this script to initialize your GitHub repository with all project management structure

set -e  # Exit on error

# Configuration
REPO_NAME="gcp-dev-platform"
ORG_OR_USER="mosgaragedev"  # Change this to your GitHub username or org
REPO_VISIBILITY="public"  # or "private"

echo "🚀 Setting up GitHub repository: $REPO_NAME"
echo "=============================================="

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "Install it from: https://cli.github.com"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo "🔐 Authenticating with GitHub..."
    gh auth login
fi

echo "✅ GitHub CLI authenticated"

# Initialize git repository if not already
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
fi

# Create directory structure
echo "📁 Creating project directory structure..."
mkdir -p .github/workflows
mkdir -p .github/ISSUE_TEMPLATE
mkdir -p docs
mkdir -p src/app
mkdir -p src/components
mkdir -p src/lib

# Create README
echo "📝 Creating README.md..."
cat > README.md << 'EOF'
# GCP Development Environment Platform

An interactive platform that automates Google Cloud development environment setup for students with learning difficulties.

## 🎯 Project Vision

Make cloud development accessible and fun for students who struggle in traditional classroom settings through:
- Visual, step-by-step environment setup
- Gamification and achievements
- Real-time progress tracking
- One-click development environments

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Setup environment variables
cp .env.example .env.local
# Edit .env.local with your credentials

# Run development server
npm run dev
```

Visit http://localhost:3000

## 📊 Project Status

- **Phase**: Foundation (Weeks 1-2)
- **Progress**: 0% → MVP Launch
- **Next Milestone**: Authentication & Database Setup
- **Target Launch**: 8 weeks

[View Project Board](https://github.com/YOUR_USERNAME/gcp-dev-platform/projects/1)

## 🏗️ Tech Stack

- **Frontend**: Next.js 14+, TypeScript, Tailwind CSS, shadcn/ui
- **Backend**: Next.js API Routes, Prisma, PostgreSQL, Redis
- **Cloud**: Google Cloud Platform (Compute, Cloud Run, Firebase)
- **Real-time**: Socket.io
- **Auth**: NextAuth.js

## 📚 Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [API Documentation](docs/API.md)
- [Contributing](docs/CONTRIBUTING.md)

## 🎮 Key Features

- **Interactive Onboarding**: Visual wizard guides students through setup
- **Real-time Provisioning**: Watch your dev environment come to life
- **Cloud IDE**: VS Code in browser, pre-configured and ready
- **Gamification**: Achievements and points keep students engaged
- **Cost Control**: Automatic budget monitoring and resource cleanup

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.

## 📄 License

MIT License - see LICENSE file for details

## 🆘 Support

- [Documentation](docs/)
- [Issue Tracker](https://github.com/YOUR_USERNAME/gcp-dev-platform/issues)
- [Discussions](https://github.com/YOUR_USERNAME/gcp-dev-platform/discussions)

---

Built with ❤️ for students who learn differently
EOF

# Create .gitignore
echo "🚫 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/
*.log

# Next.js
.next/
out/
build/
dist/

# Environment variables
.env
.env*.local
.env.production

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Prisma
prisma/*.db
prisma/*.db-journal

# Misc
*.pem
.cache/
EOF

# Create initial commit
echo "💾 Creating initial commit..."
git add .
git commit -m "Initial project structure

- Setup repository structure
- Add README with project vision
- Configure gitignore
" || echo "Nothing to commit"

# Create GitHub repository
echo "🌐 Creating GitHub repository..."
if gh repo view "$ORG_OR_USER/$REPO_NAME" &> /dev/null; then
    echo "⚠️  Repository already exists, skipping creation"
else
    gh repo create "$ORG_OR_USER/$REPO_NAME" \
        --"$REPO_VISIBILITY" \
        --source=. \
        --remote=origin \
        --description="Interactive Google Cloud development environment platform for students"

    echo "✅ Repository created"
fi

# Push to GitHub
echo "📤 Pushing to GitHub..."
git push -u origin main || echo "Already pushed"

# Create milestones
echo "🎯 Creating project milestones..."

gh api repos/$ORG_OR_USER/$REPO_NAME/milestones \
  -f title="Milestone 1: Foundation" \
  -f description="Weeks 1-2: Project setup, authentication, and database infrastructure" \
  -f due_on="2026-05-09T23:59:59Z" \
  -f state="open" || echo "Milestone 1 may already exist"

gh api repos/$ORG_OR_USER/$REPO_NAME/milestones \
  -f title="Milestone 2: Core Features" \
  -f description="Weeks 3-4: GCP integration, provisioning engine, and dashboard UI" \
  -f due_on="2026-05-23T23:59:59Z" \
  -f state="open" || echo "Milestone 2 may already exist"

gh api repos/$ORG_OR_USER/$REPO_NAME/milestones \
  -f title="Milestone 3: Engagement" \
  -f description="Weeks 5-6: Gamification, onboarding, and IDE configuration" \
  -f due_on="2026-06-06T23:59:59Z" \
  -f state="open" || echo "Milestone 3 may already exist"

gh api repos/$ORG_OR_USER/$REPO_NAME/milestones \
  -f title="Milestone 4: Launch" \
  -f description="Weeks 7-8: Security, testing, documentation, and beta launch" \
  -f due_on="2026-06-20T23:59:59Z" \
  -f state="open" || echo "Milestone 4 may already exist"

# Create labels
echo "🏷️  Creating issue labels..."

# Priority labels
gh label create "critical" --color "B60205" --description "Critical priority" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "high" --color "D93F0B" --description "High priority" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "medium" --color "FBCA04" --description "Medium priority" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "low" --color "0E8A16" --description "Low priority" --repo "$ORG_OR_USER/$REPO_NAME" --force

# Type labels
gh label create "bug" --color "D73A4A" --description "Something isn't working" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "feature" --color "A2EEEF" --description "New feature or request" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "enhancement" --color "84B6EB" --description "Enhancement to existing feature" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "documentation" --color "0075CA" --description "Documentation improvements" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "testing" --color "D4C5F9" --description "Testing related" --repo "$ORG_OR_USER/$REPO_NAME" --force

# Area labels
gh label create "frontend" --color "C5DEF5" --description "Frontend code" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "backend" --color "5319E7" --description "Backend code" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "database" --color "8B4513" --description "Database related" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "devops" --color "666666" --description "DevOps and infrastructure" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "design" --color "FF69B4" --description "Design and UX" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "gcp" --color "4285F4" --description "Google Cloud Platform" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "security" --color "DC143C" --description "Security related" --repo "$ORG_OR_USER/$REPO_NAME" --force

# Status labels
gh label create "blocked" --color "B60205" --description "Blocked by another issue" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "in-progress" --color "FBCA04" --description "Currently being worked on" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "ready-for-review" --color "0E8A16" --description "Ready for code review" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "needs-discussion" --color "D876E3" --description "Needs team discussion" --repo "$ORG_OR_USER/$REPO_NAME" --force

# Special labels
gh label create "good-first-issue" --color "7057FF" --description "Good for newcomers" --repo "$ORG_OR_USER/$REPO_NAME" --force
gh label create "help-wanted" --color "008672" --description "Extra attention needed" --repo "$ORG_OR_USER/$REPO_NAME" --force

echo "✅ Labels created"

# Create GitHub Project
echo "📋 Creating GitHub Project Board..."
echo ""
echo "Note: GitHub Projects v2 requires manual creation via web interface"
echo "Visit: https://github.com/$ORG_OR_USER/$REPO_NAME/projects/new"
echo ""
echo "Recommended project structure:"
echo "  - Backlog"
echo "  - Todo"
echo "  - In Progress"
echo "  - In Review"
echo "  - Done"

# Create issue templates
echo "📝 Creating issue templates..."

cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug Report
about: Report a bug or issue
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description
A clear description of what the bug is.

## Steps to Reproduce
1. Go to '...'
2. Click on '....'
3. See error

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Screenshots
If applicable, add screenshots.

## Environment
- Browser: [e.g. Chrome 120]
- OS: [e.g. macOS 14]
- Version: [e.g. 1.0.0]

## Additional Context
Any other context about the problem.
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature Request
about: Suggest a new feature
title: '[FEATURE] '
labels: feature
assignees: ''
---

## Feature Description
A clear description of the feature you'd like.

## Problem it Solves
What problem does this feature solve?

## Proposed Solution
How should this work?

## Alternatives Considered
Any alternative solutions or features you've considered?

## Additional Context
Any other context, mockups, or examples.
EOF

cat > .github/ISSUE_TEMPLATE/user_story.md << 'EOF'
---
name: User Story
about: Describe a user story for development
title: '[STORY] '
labels: feature
assignees: ''
---

## User Story
As a [type of user], I want [goal] so that [benefit].

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Technical Notes
Any technical considerations or constraints.

## Story Points
Estimated effort: [1, 2, 3, 5, 8, 13, 21]

## Dependencies
Related issues or blockers.
EOF

# Create PR template
cat > .github/PULL_REQUEST_TEMPLATE.md << 'EOF'
## Description
Brief description of changes.

## Related Issue
Fixes #(issue number)

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests passing
- [ ] No new warnings

## Screenshots (if applicable)

## Additional Notes
EOF

# Commit templates
git add .github/
git commit -m "Add issue and PR templates" || echo "Templates already committed"
git push origin main || echo "Already pushed"

echo ""
echo "=============================================="
echo "✅ GitHub repository setup complete!"
echo "=============================================="
echo ""
echo "📍 Repository: https://github.com/$ORG_OR_USER/$REPO_NAME"
echo ""
echo "Next steps:"
echo "1. Create GitHub Project Board manually (Projects v2)"
echo "2. Import issues from the provided template"
echo "3. Setup branch protection rules"
echo "4. Configure GitHub Actions secrets"
echo "5. Invite team members"
echo ""
echo "To create issues, use the templates in:"
echo "  GitHub Issues Template artifact"
echo ""
echo "Happy coding! 🚀"
