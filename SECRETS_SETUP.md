# ============================================================
#  GitHub Secrets Setup Guide
#  Settings → Secrets and Variables → Actions → New secret
# ============================================================

## Required Secrets (masa-odoo18-app repo)

| Secret Name        | Value                              | Where to get it                          |
|--------------------|------------------------------------|------------------------------------------|
| DOCKERHUB_USERNAME | your Docker Hub username           | hub.docker.com → Account Settings       |
| DOCKERHUB_TOKEN    | Docker Hub access token            | hub.docker.com → Security → New Token   |
| GITOPS_TOKEN       | GitHub PAT with repo write access  | GitHub → Settings → Developer Settings  |

## How to create GITOPS_TOKEN (GitHub Personal Access Token)

1. Go to: GitHub → Settings → Developer Settings → Personal Access Tokens → Fine-grained tokens
2. Click "Generate new token"
3. Set:
   - Token name: masa-gitops-bot
   - Expiration: 90 days (or no expiry for automation)
   - Repository access: Only select repositories → masa-technology/masa-odoo18-chart
   - Permissions:
     - Contents: Read and Write   ← required to push image tag updates
     - Metadata: Read-only
4. Copy the token → paste as GITOPS_TOKEN secret

## GitHub Environment Setup (for Production approval gate)

1. Go to: masa-odoo18-app repo → Settings → Environments
2. Click "New environment" → name it: production
3. Enable "Required reviewers" → add your team leads
4. This creates a manual approval step before the production job runs

## Quick setup via GitHub CLI

  gh secret set DOCKERHUB_USERNAME --body "your-username"
  gh secret set DOCKERHUB_TOKEN    --body "your-docker-token"
  gh secret set GITOPS_TOKEN       --body "your-github-pat"
