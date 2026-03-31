#!/bin/bash
# MAOS GitHub Setup Script
# Run this AFTER you've created the repository on github.com
#
# Usage:
#   chmod +x setup-github.sh
#   ./setup-github.sh YOUR-GITHUB-USERNAME
#
# Example:
#   ./setup-github.sh udohellmann

if [ -z "$1" ]; then
  echo ""
  echo "MAOS GitHub Setup"
  echo "================="
  echo ""
  echo "Usage: ./setup-github.sh YOUR-GITHUB-USERNAME"
  echo ""
  echo "Before running this script:"
  echo "  1. Go to https://github.com/new"
  echo "  2. Repository name: maos"
  echo "  3. Description: A living reference architecture for secure AI agent systems"
  echo "  4. Set to Public"
  echo "  5. Do NOT add README, .gitignore, or license (we have our own)"
  echo "  6. Click 'Create repository'"
  echo "  7. Then come back and run: ./setup-github.sh YOUR-GITHUB-USERNAME"
  echo ""
  exit 1
fi

USERNAME=$1

echo ""
echo "Setting up MAOS repository for github.com/$USERNAME/maos"
echo ""

git init
git add .
git commit -m "MAOS v5.8 — initial publication

A living reference architecture for secure multi-agent systems.
19 files: core spec, executive summary, architecture overview,
7 companion documents, 3 issue templates, contributing guide.

Author: Udo Hellmann
License: Apache 2.0"

git branch -M main
git remote add origin "https://github.com/$USERNAME/maos.git"

echo ""
echo "Repository initialized. Now run:"
echo ""
echo "  git push -u origin main"
echo ""
echo "After pushing, go to your repository settings and add these topics:"
echo "  ai-agents, security, multi-agent-systems, llm, agent-framework,"
echo "  reference-architecture, ai-safety, eu-ai-act"
echo ""
echo "Done!"
