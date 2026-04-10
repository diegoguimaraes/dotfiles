#!/bin/bash

# Generate AI commit message and prepare it for lazygit's commit dialog
set -e

# Check git repository and staged changes
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    exit 1
fi

if git diff --cached --quiet; then
    echo "Error: No staged changes to commit" >&2
    exit 1
fi

# Gather context
DIFF=$(git diff --cached)
STATS=$(git diff --cached --stat)
FILES=$(git diff --cached --name-only | tr '\n' ', ' | sed 's/,$//')
BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
RECENT=$(git log --oneline -3 2>/dev/null || echo "")

# Create enhanced context for AI
CONTEXT="Repository Context:
- Branch: $BRANCH
- Files: $FILES
- Stats: $STATS
- Recent commits: $RECENT

Changes:
$DIFF"

# Generate commit message
COMMIT_MESSAGE=$(echo "$CONTEXT" | zllm -T git-commit 2>/dev/null)

if [ -z "$COMMIT_MESSAGE" ]; then
    echo "Error: Failed to generate commit message" >&2
    exit 1
fi

# Save to the file that lazygit checks for pending commit messages
echo "$COMMIT_MESSAGE" > .git/LAZYGIT_PENDING_COMMIT

# Automatically trigger the 'c' key in Lazygit
osascript -e 'tell application "System Events" to keystroke "c"'
