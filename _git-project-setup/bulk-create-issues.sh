#!/bin/bash
# Bulk Create GitHub Issues for GCP Dev Platform
# This script creates all 16 issues with proper labels, milestones, and metadata

set -e  # Exit on error

# Configuration
REPO="mosgaragedev/gcp-dev-platform"  # Change this!

echo "🚀 Bulk Creating GitHub Issues"
echo "Repository: $REPO"
echo "======================================"

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "Install it from: https://cli.github.com"
    exit 1
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub"
    echo "Run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI ready"
echo ""

# Function to create an issue
create_issue() {
    local title="$1"
    local body="$2"
    local labels="$3"
    local milestone="$4"

    echo "Creating: $title"

    gh issue create \
        --repo "$REPO" \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --milestone "$milestone" || echo "  ⚠️ Failed (might already exist)"

    echo "  ✓ Done"
    echo ""
}

# ============================================
# MILESTONE 1: FOUNDATION
# ============================================

echo "📦 Creating Milestone 1 Issues..."
echo ""

# Issue 1: Project Setup
create_issue \
"[SETUP] Project Initialization & DevOps" \
"Initialize the Next.js project with all development tooling and CI/CD pipelines.

## Tasks
- [ ] Initialize Next.js 14+ project with TypeScript and App Router
- [ ] Configure ESLint, Prettier, and Husky for pre-commit hooks
- [ ] Setup GitHub Actions CI/CD pipeline (lint, test, build)
- [ ] Configure staging and production deployment environments
- [ ] Create Docker containers for local development
- [ ] Setup environment variable management (.env templates)
- [ ] Document local development setup in README

## Acceptance Criteria
- \`npm run dev\` works on fresh clone
- CI pipeline runs on every PR
- Code quality tools enforce standards
- Deployment to staging works automatically

## Story Points
8

## Technical Notes
Use Next.js App Router with TypeScript. Setup ESLint with Airbnb config and Prettier integration." \
"setup,infrastructure,high,good-first-issue" \
"Milestone 1: Foundation"

# Issue 2: Authentication
create_issue \
"[AUTH] Google OAuth 2.0 Implementation" \
"Implement complete Google OAuth 2.0 authentication flow with token management and encryption.

## Tasks
- [ ] Install and configure NextAuth.js v5
- [ ] Setup Google OAuth provider with correct scopes
- [ ] Implement OAuth callback handling
- [ ] Create token refresh mechanism (access + refresh tokens)
- [ ] Build token encryption utilities (AES-256)
- [ ] Add authentication middleware for protected routes
- [ ] Store encrypted refresh tokens in database
- [ ] Cache access tokens in Redis with TTL
- [ ] Write unit tests for authentication flow
- [ ] Add error handling for failed authentication

## Acceptance Criteria
- Users can sign in with Google account
- Tokens refresh automatically before expiry
- Refresh tokens stored encrypted in database
- Session persists across browser restarts
- Test coverage >80%

## Story Points
13

## Required Scopes
\`\`\`javascript
const scopes = [
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/firebase',
  'https://www.googleapis.com/auth/compute',
];
\`\`\`" \
"authentication,backend,high,critical" \
"Milestone 1: Foundation"

# Issue 3: Database
create_issue \
"[DATABASE] Schema Design & Setup" \
"Design and implement PostgreSQL database schema with Prisma ORM and Redis for caching.

## Tasks
- [ ] Design Prisma schema (users, projects, achievements, logs)
- [ ] Setup PostgreSQL database (local + cloud)
- [ ] Configure Redis for session management
- [ ] Create initial database migrations
- [ ] Build database seeding scripts for development
- [ ] Write database access layer (repositories)
- [ ] Add database connection pooling
- [ ] Setup automated backups
- [ ] Document schema design decisions

## Acceptance Criteria
- Prisma migrations run successfully
- Seed data populates development database
- Redis caching works for sessions
- Database queries are type-safe
- Schema documented in docs/

## Story Points
8

## Schema Reference
See main architecture document Section 5 for complete schema design." \
"database,backend,high" \
"Milestone 1: Foundation"

# Issue 4: UI Components
create_issue \
"[UI] Design System & Core Components" \
"Build design system with Tailwind CSS and shadcn/ui component library.

## Tasks
- [ ] Setup Tailwind CSS with custom configuration
- [ ] Install and configure shadcn/ui
- [ ] Create design tokens (colors, spacing, typography, shadows)
- [ ] Build core UI components (Button, Card, Modal, Input, Badge)
- [ ] Implement responsive layout system
- [ ] Add dark mode support
- [ ] Create loading states and skeletons
- [ ] Setup Storybook for component documentation
- [ ] Write component usage examples
- [ ] Ensure accessibility (WCAG 2.1 AA)

## Acceptance Criteria
- All components render in Storybook
- Components work in light and dark mode
- Responsive on mobile, tablet, desktop
- Keyboard navigation works
- Screen reader compatible

## Story Points
13

## Design System
Use Tailwind CSS v3+ with shadcn/ui components. Follow Material Design 3 principles for accessibility." \
"frontend,design,medium" \
"Milestone 1: Foundation"

# ============================================
# MILESTONE 2: CORE FEATURES
# ============================================

echo "⚙️ Creating Milestone 2 Issues..."
echo ""

# Issue 5: GCP Integration
create_issue \
"[GCP] Google Cloud Integration" \
"Integrate Google Cloud SDK and implement project creation automation.

## Tasks
- [ ] Setup Google Cloud SDK for Node.js
- [ ] Create service account with appropriate permissions
- [ ] Implement GCP project creation API
- [ ] Enable required APIs automatically (Compute, Cloud Run, Firebase, etc.)
- [ ] Configure IAM roles and permissions for user projects
- [ ] Build retry logic for API rate limits
- [ ] Add comprehensive error handling for GCP operations
- [ ] Write integration tests with mocked GCP responses
- [ ] Document GCP setup requirements
- [ ] Add cost estimation before provisioning

## Acceptance Criteria
- Can create GCP projects programmatically
- Required APIs enable automatically
- IAM permissions set correctly
- Handles rate limiting gracefully
- Error messages are user-friendly

## Story Points
21

## Required APIs
- Compute Engine API
- Cloud Run API
- Firebase Management API
- Cloud Resource Manager API
- Cloud Storage API
- IAM API" \
"backend,gcp,critical,high" \
"Milestone 2: Core Features"

# Issue 6: Provisioning Engine
create_issue \
"[PROVISION] Resource Provisioning Engine" \
"Build orchestrator to provision development environment resources on Google Cloud.

## Tasks
- [ ] Design provisioning orchestrator architecture
- [ ] Implement Cloud Run deployment for code-server
- [ ] Setup Firebase project initialization
- [ ] Create Cloud Storage buckets with proper permissions
- [ ] Build step-by-step provisioning workflow
- [ ] Add rollback mechanism for failed provisions
- [ ] Implement idempotent operations (can safely retry)
- [ ] Track provisioning status in database
- [ ] Add timeout handling (max 10 minutes)
- [ ] Log all provisioning steps for debugging

## Acceptance Criteria
- Code-server deploys successfully to Cloud Run
- Firebase project initializes with auth enabled
- Storage buckets created with correct permissions
- Failed provisions roll back cleanly
- Provisioning completes in <5 minutes
- All steps logged to database

## Story Points
21

## Architecture
\`\`\`
Orchestrator → GCP Project → Enable APIs → Deploy Resources → Configure
\`\`\`" \
"backend,gcp,critical,high" \
"Milestone 2: Core Features"

# Issue 7: WebSocket Progress
create_issue \
"[REALTIME] WebSocket Progress Tracking" \
"Implement real-time progress updates using WebSockets during provisioning.

## Tasks
- [ ] Setup Socket.io server in Next.js API routes
- [ ] Implement progress event emitters in provisioning engine
- [ ] Create client-side WebSocket connection hooks
- [ ] Build real-time progress UI component with animations
- [ ] Add reconnection logic for dropped connections
- [ ] Handle multiple concurrent provisions
- [ ] Test with slow network conditions
- [ ] Add heartbeat/ping-pong for connection health
- [ ] Implement graceful fallback to polling if WebSocket fails

## Acceptance Criteria
- Progress updates appear in real-time (<500ms latency)
- UI shows current step and overall progress
- Reconnects automatically if connection drops
- Works on slow 3G connections
- Multiple users can provision simultaneously

## Story Points
13

## Events
- \`provision:start\`
- \`provision:progress\` (with step details)
- \`provision:complete\`
- \`provision:error\`" \
"backend,frontend,realtime,high" \
"Milestone 2: Core Features"

# Issue 8: Dashboard UI
create_issue \
"[DASHBOARD] Main Dashboard UI" \
"Build the main dashboard interface for managing development projects.

## Tasks
- [ ] Design dashboard layout in Figma (get approval)
- [ ] Build project cards component with status indicators
- [ ] Implement project list with filtering and sorting
- [ ] Create \"New Project\" wizard (multi-step form)
- [ ] Add loading states and skeleton screens
- [ ] Implement responsive design for mobile
- [ ] Build quick actions menu
- [ ] Add empty states (no projects yet)
- [ ] Integrate with real-time updates
- [ ] Add animations for card interactions

## Acceptance Criteria
- Dashboard shows all user projects
- Can create new project via wizard
- Projects filterable by status
- Responsive on all screen sizes
- Loading states prevent layout shift
- Animations smooth (60fps)

## Story Points
13

## Features
- Active projects grid
- Quick actions toolbar
- Progress/achievements summary
- Recent activity feed" \
"frontend,critical,high" \
"Milestone 2: Core Features"

# ============================================
# MILESTONE 3: ENGAGEMENT
# ============================================

echo "🎮 Creating Milestone 3 Issues..."
echo ""

# Issue 9: Gamification
create_issue \
"[GAMIFICATION] Achievement System" \
"Create gamification system with achievements, points, and leveling.

## Tasks
- [ ] Design achievement types and unlock criteria
- [ ] Implement achievement detection logic (backend)
- [ ] Create achievement database schema
- [ ] Build achievement unlock animations (confetti, badges)
- [ ] Design and implement points system
- [ ] Create leveling algorithm
- [ ] Build achievement showcase UI
- [ ] Add achievement notifications (toast messages)
- [ ] Track achievement progress
- [ ] Create achievement icons/graphics

## Acceptance Criteria
- Achievements unlock when criteria met
- Visual celebration when achievement earned
- Achievement history visible in profile
- Points contribute to level progression
- Notifications appear without being intrusive

## Story Points
13

## Achievement Examples
- \"First Steps\" - Complete onboarding
- \"Environment Master\" - Create first project
- \"Speed Runner\" - Setup in <3 minutes
- \"Consistency King\" - 7 day login streak" \
"backend,frontend,gamification,medium" \
"Milestone 3: Engagement"

# Issue 10: Onboarding
create_issue \
"[ONBOARDING] User Onboarding Flow" \
"Design and implement smooth first-time user onboarding experience.

## Tasks
- [ ] Design multi-step onboarding wizard (Figma)
- [ ] Implement goal selection screen
- [ ] Create service selection cards with previews
- [ ] Build progress visualization (step indicators)
- [ ] Add celebration animations (confetti on completion)
- [ ] Write engaging onboarding copy
- [ ] Add helpful tooltips and hints
- [ ] Implement skip/back navigation
- [ ] Save progress if user exits
- [ ] Add optional tutorial mode

## Acceptance Criteria
- New users complete onboarding in <5 minutes
- Each step clearly explains what's happening
- Progress is always visible
- Can go back to change selections
- Completion feels rewarding
- Works on mobile devices

## Story Points
13

## Steps
1. Welcome & Introduction
2. Goal Selection
3. Google Cloud Connection
4. Service Selection
5. Environment Setup
6. Celebration & Launch" \
"frontend,ux,high" \
"Milestone 3: Engagement"

# Issue 11: Code-Server
create_issue \
"[IDE] Code-Server Configuration" \
"Configure custom code-server (VS Code in browser) environment.

## Tasks
- [ ] Create custom code-server Docker image
- [ ] Pre-install essential VS Code extensions
- [ ] Configure default themes and settings
- [ ] Setup sample project templates
- [ ] Implement auto-save and cloud sync
- [ ] Add integrated terminal with helpful aliases
- [ ] Configure Git integration
- [ ] Setup debugging configurations
- [ ] Add welcome page with quick links
- [ ] Optimize image size and build time

## Acceptance Criteria
- Code-server loads in <10 seconds
- All extensions work correctly
- Settings persist across sessions
- Sample projects available
- Terminal has helpful defaults
- Git authentication works

## Story Points
13

## Extensions
- Python
- ESLint
- Prettier
- Firebase
- Docker
- GitLens" \
"backend,devex,medium,devops" \
"Milestone 3: Engagement"

# ============================================
# MILESTONE 4: LAUNCH
# ============================================

echo "🚀 Creating Milestone 4 Issues..."
echo ""

# Issue 12: Security
create_issue \
"[SECURITY] Security Hardening" \
"Implement comprehensive security measures and best practices.

## Tasks
- [ ] Implement rate limiting on all API routes
- [ ] Add CSRF protection
- [ ] Setup Content Security Policy (CSP) headers
- [ ] Audit all dependencies for vulnerabilities
- [ ] Implement token encryption at rest (AES-256)
- [ ] Add security headers (HSTS, X-Frame-Options, etc.)
- [ ] Setup input validation and sanitization
- [ ] Implement request signing
- [ ] Conduct penetration testing
- [ ] Document security practices

## Acceptance Criteria
- Rate limiting prevents abuse
- No CSRF vulnerabilities
- All dependencies up-to-date and secure
- Security headers present on all responses
- Passes OWASP top 10 checklist
- Penetration test report clean

## Story Points
13

## Checklist
- [ ] SQL injection prevention
- [ ] XSS protection
- [ ] CSRF tokens
- [ ] Rate limiting
- [ ] Input validation
- [ ] Secure headers" \
"security,backend,critical,high" \
"Milestone 4: Launch"

# Issue 13: Cost Control
create_issue \
"[COST] Cost Control & Monitoring" \
"Implement cost monitoring and automatic resource management.

## Tasks
- [ ] Implement budget alerts per user
- [ ] Create automatic resource cleanup (delete idle projects)
- [ ] Add usage quotas per user (\$10/month default)
- [ ] Build cost dashboard for admin
- [ ] Setup idle resource detection (2+ hours inactive)
- [ ] Configure auto-shutdown policies
- [ ] Implement cost estimation before provisioning
- [ ] Add billing notification emails
- [ ] Create cost reports

## Acceptance Criteria
- Budget alerts trigger at 50%, 80%, 100%
- Idle resources auto-shutdown after 2 hours
- Users notified before shutdown
- Cost dashboard shows real-time usage
- Quotas enforced automatically

## Story Points
8

## Controls
- \$10/user/month budget
- Auto-shutdown after 2hr idle
- Max 3 active projects per user
- Cleanup projects >30 days old" \
"backend,monitoring,high" \
"Milestone 4: Launch"

# Issue 14: Documentation
create_issue \
"[DOCS] Documentation & Guides" \
"Create comprehensive documentation for users and developers.

## Tasks
- [ ] Write deployment guide (step-by-step)
- [ ] Create API documentation (OpenAPI/Swagger)
- [ ] Write student user guide (with screenshots)
- [ ] Create video tutorials (onboarding, common tasks)
- [ ] Build troubleshooting guide (FAQ)
- [ ] Document architecture decisions (ADRs)
- [ ] Write contributing guidelines
- [ ] Create code examples and snippets
- [ ] Setup documentation site (Docusaurus/GitBook)

## Acceptance Criteria
- Deployment guide enables fresh setup
- API docs auto-generated from code
- User guide answers common questions
- Videos cover key workflows
- Troubleshooting guide has solutions
- Documentation searchable

## Story Points
8

## Sections
- Getting Started
- User Guide
- API Reference
- Architecture
- Deployment
- Troubleshooting" \
"documentation,medium" \
"Milestone 4: Launch"

# Issue 15: Testing
create_issue \
"[TESTING] E2E Testing & QA" \
"Implement comprehensive end-to-end testing and QA process.

## Tasks
- [ ] Setup Playwright or Cypress for E2E tests
- [ ] Write critical path E2E tests (signup → provision → launch)
- [ ] Create test data fixtures and factories
- [ ] Develop manual QA test plan
- [ ] Conduct performance testing (load, stress)
- [ ] Run accessibility audit (WAVE, axe)
- [ ] Test on different browsers (Chrome, Firefox, Safari)
- [ ] Mobile device testing (iOS, Android)
- [ ] Setup visual regression testing
- [ ] Create test execution reports

## Acceptance Criteria
- E2E tests cover critical user journeys
- Tests run in CI pipeline
- Test coverage >70% for E2E
- Accessibility score >90
- Works on all major browsers
- Mobile experience tested

## Story Points
13

## Scenarios
- New user signup and onboarding
- Project creation and provisioning
- IDE launch and usage
- Achievement unlocking
- Error handling" \
"testing,qa,high" \
"Milestone 4: Launch"

# Issue 16: Beta Launch
create_issue \
"[BETA] Beta Launch Preparation" \
"Prepare all infrastructure and processes for beta launch.

## Tasks
- [ ] Setup error monitoring (Sentry or similar)
- [ ] Configure analytics (PostHog, Mixpanel, or GA4)
- [ ] Create user feedback collection form
- [ ] Prepare launch announcement (blog, email)
- [ ] Recruit 10-20 beta testers from target audience
- [ ] Setup support documentation and help center
- [ ] Create onboarding email sequence
- [ ] Prepare demo videos
- [ ] Setup monitoring dashboards
- [ ] Plan weekly check-ins with beta testers

## Acceptance Criteria
- Error tracking captures all issues
- Analytics tracks key user actions
- Feedback form easily accessible
- Beta testers recruited and onboarded
- Support channels staffed
- Launch announcement ready

## Story Points
8

## Success Metrics
- 80% completion rate for onboarding
- <5 min average setup time
- 60%+ return rate after first use
- <5% error rate during provisioning" \
"launch,critical,high" \
"Milestone 4: Launch"

echo ""
echo "======================================"
echo "✅ All 16 issues created successfully!"
echo "======================================"
echo ""
echo "View them at: https://github.com/$REPO/issues"
echo ""
echo "Next steps:"
echo "1. Review all issues"
echo "2. Assign team members"
echo "3. Add to project board"
echo "4. Start Sprint 1!"
echo ""
echo "🎉 Happy building!"
