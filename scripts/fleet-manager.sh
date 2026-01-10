#!/bin/bash
#
# Fleet Manager - Manage multiple Claude Code instances
# Part of the Boris Cherny "Fleet Commander" Workflow
#

set -e

FLEET_DIR=".claude/fleet"
TASK_LOG=".claude/task-log.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ensure fleet directory exists
mkdir -p "$FLEET_DIR"

# Help message
show_help() {
  cat << EOF
Fleet Manager - Manage multiple Claude Code instances

Usage: ./scripts/fleet-manager.sh [command] [options]

Commands:
  status              Show status of all instances
  assign [tab] [task] Assign a task to a specific instance
  complete [tab]      Mark instance task as complete
  log                 Show task completion log
  summary             Show summary of fleet activity
  init                Initialize fleet management

Examples:
  ./scripts/fleet-manager.sh status
  ./scripts/fleet-manager.sh assign 1 "Implement authentication"
  ./scripts/fleet-manager.sh complete 1
  ./scripts/fleet-manager.sh log
EOF
}

# Initialize fleet management
init_fleet() {
  echo -e "${BLUE}Initializing Fleet Commander...${NC}"

  # Create instance files
  for i in {1..5}; do
    INSTANCE_FILE="$FLEET_DIR/instance-$i.json"
    if [[ ! -f "$INSTANCE_FILE" ]]; then
      cat > "$INSTANCE_FILE" << EOF
{
  "instance": $i,
  "status": "idle",
  "current_task": null,
  "started_at": null,
  "completed_tasks": 0
}
EOF
      echo -e "${GREEN}✓${NC} Created instance $i"
    fi
  done

  # Create task log if it doesn't exist
  touch "$TASK_LOG"

  echo -e "${GREEN}✓${NC} Fleet Commander initialized"
  echo ""
  echo "Next steps:"
  echo "  1. Open 5 terminal tabs"
  echo "  2. Run 'claude-code' in each tab"
  echo "  3. Use './scripts/fleet-manager.sh assign' to queue tasks"
}

# Show status of all instances
show_status() {
  echo -e "${BLUE}Fleet Status${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  for i in {1..5}; do
    INSTANCE_FILE="$FLEET_DIR/instance-$i.json"

    if [[ ! -f "$INSTANCE_FILE" ]]; then
      echo -e "Tab $i: ${RED}Not initialized${NC}"
      continue
    fi

    STATUS=$(jq -r '.status' "$INSTANCE_FILE")
    TASK=$(jq -r '.current_task' "$INSTANCE_FILE")
    COMPLETED=$(jq -r '.completed_tasks' "$INSTANCE_FILE")

    if [[ "$STATUS" == "idle" ]]; then
      echo -e "Tab $i: ${GREEN}[IDLE]${NC} Ready for tasks (Completed: $COMPLETED)"
    elif [[ "$STATUS" == "in_progress" ]]; then
      echo -e "Tab $i: ${YELLOW}[IN PROGRESS]${NC} $TASK"
    elif [[ "$STATUS" == "completed" ]]; then
      echo -e "Tab $i: ${BLUE}[COMPLETED]${NC} $TASK (Ready for review)"
    fi
  done

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Assign task to instance
assign_task() {
  local instance=$1
  local task=$2

  if [[ -z "$instance" || -z "$task" ]]; then
    echo -e "${RED}Error: Instance number and task description required${NC}"
    echo "Usage: ./scripts/fleet-manager.sh assign [instance] [task]"
    exit 1
  fi

  INSTANCE_FILE="$FLEET_DIR/instance-$instance.json"

  if [[ ! -f "$INSTANCE_FILE" ]]; then
    echo -e "${RED}Error: Instance $instance not initialized${NC}"
    echo "Run: ./scripts/fleet-manager.sh init"
    exit 1
  fi

  # Update instance file
  jq --arg task "$task" \
     --arg time "$(date -Iseconds)" \
     '.status = "in_progress" | .current_task = $task | .started_at = $time' \
     "$INSTANCE_FILE" > "$INSTANCE_FILE.tmp" && mv "$INSTANCE_FILE.tmp" "$INSTANCE_FILE"

  echo -e "${GREEN}✓${NC} Assigned to Tab $instance: $task"
  echo ""
  echo "Switch to Tab $instance and begin work on this task."
}

# Mark task as complete
complete_task() {
  local instance=$1

  if [[ -z "$instance" ]]; then
    echo -e "${RED}Error: Instance number required${NC}"
    echo "Usage: ./scripts/fleet-manager.sh complete [instance]"
    exit 1
  fi

  INSTANCE_FILE="$FLEET_DIR/instance-$instance.json"

  if [[ ! -f "$INSTANCE_FILE" ]]; then
    echo -e "${RED}Error: Instance $instance not initialized${NC}"
    exit 1
  fi

  TASK=$(jq -r '.current_task' "$INSTANCE_FILE")
  STARTED=$(jq -r '.started_at' "$INSTANCE_FILE")

  # Log completion
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Instance $instance: $TASK - COMPLETED (Started: $STARTED)" >> "$TASK_LOG"

  # Update instance file
  jq '.status = "idle" | .current_task = null | .started_at = null | .completed_tasks += 1' \
     "$INSTANCE_FILE" > "$INSTANCE_FILE.tmp" && mv "$INSTANCE_FILE.tmp" "$INSTANCE_FILE"

  COMPLETED=$(jq -r '.completed_tasks' "$INSTANCE_FILE")

  echo -e "${GREEN}✓${NC} Tab $instance: Task complete!"
  echo "Total tasks completed: $COMPLETED"
}

# Show task log
show_log() {
  echo -e "${BLUE}Task Completion Log${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  if [[ ! -f "$TASK_LOG" || ! -s "$TASK_LOG" ]]; then
    echo "No tasks completed yet."
  else
    tail -n 20 "$TASK_LOG"
  fi

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Show summary
show_summary() {
  echo -e "${BLUE}Fleet Commander Summary${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local total_completed=0
  local active_tasks=0
  local idle_instances=0

  for i in {1..5}; do
    INSTANCE_FILE="$FLEET_DIR/instance-$i.json"

    if [[ -f "$INSTANCE_FILE" ]]; then
      STATUS=$(jq -r '.status' "$INSTANCE_FILE")
      COMPLETED=$(jq -r '.completed_tasks' "$INSTANCE_FILE")

      total_completed=$((total_completed + COMPLETED))

      if [[ "$STATUS" == "in_progress" ]]; then
        active_tasks=$((active_tasks + 1))
      elif [[ "$STATUS" == "idle" ]]; then
        idle_instances=$((idle_instances + 1))
      fi
    fi
  done

  echo -e "Total Tasks Completed:  ${GREEN}$total_completed${NC}"
  echo -e "Active Tasks:           ${YELLOW}$active_tasks${NC}"
  echo -e "Idle Instances:         ${BLUE}$idle_instances${NC}"
  echo ""

  # Recent activity
  echo -e "${BLUE}Recent Activity:${NC}"
  if [[ -f "$TASK_LOG" && -s "$TASK_LOG" ]]; then
    tail -n 5 "$TASK_LOG"
  else
    echo "No recent activity"
  fi

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Main command router
case "$1" in
  init)
    init_fleet
    ;;
  status)
    show_status
    ;;
  assign)
    assign_task "$2" "$3"
    ;;
  complete)
    complete_task "$2"
    ;;
  log)
    show_log
    ;;
  summary)
    show_summary
    ;;
  help|--help|-h)
    show_help
    ;;
  *)
    echo -e "${RED}Error: Unknown command '$1'${NC}"
    echo ""
    show_help
    exit 1
    ;;
esac
