#!/usr/bin/env bash
# BMAD OpenClaw launcher — convenience wrapper
# Usage: bmad-launcher.sh <phase> <project_root> <docs_path>
# phases: readiness | create-stories | dev-story | code-review | qa | retrospective

set -euo pipefail
PHASE=${1:-}
PROJECT_ROOT=${2:-}
DOCS_PATH=${3:-}

if [[ -z "$PHASE" || -z "$PROJECT_ROOT" || -z "$DOCS_PATH" ]]; then
  echo "Usage: $0 <phase> <project_root> <docs_path>"
  exit 1
fi

case "$PHASE" in
  readiness)
    AGENT="readiness-check"; LABEL="bmad-readiness-check"; TASK="Run readiness check"; ;;
  create-stories)
    AGENT="create-story"; LABEL="bmad-create-story"; TASK="Create stories from epics"; ;;
  dev-story)
    AGENT="dev-story"; LABEL="bmad-dev-story"; TASK="Implement the next dev story"; ;;
  code-review)
    AGENT="code-review"; LABEL="bmad-code-review"; TASK="Perform code review"; ;;
  qa)
    AGENT="qa-tester"; LABEL="bmad-qa"; TASK="Run QA checks"; ;;
  retrospective)
    AGENT="retrospective"; LABEL="bmad-retro"; TASK="Run sprint retrospective"; ;;
  *)
    echo "Unknown phase: $PHASE"; exit 1;;
esac

cat <<EOF
Run this in a session:
sessions_spawn({
  task: "$TASK",
  agentId: "$AGENT",
  label: "$LABEL",
  env: {
    PROJECT_ROOT: "$PROJECT_ROOT",
    PLANNING_ARTIFACTS: "$DOCS_PATH",
    IMPLEMENTATION_ARTIFACTS: "$DOCS_PATH"
  }
});
EOF
