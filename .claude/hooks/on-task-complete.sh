#!/bin/bash
#
# On-Task-Complete Hook
# Sends system notification when background task completes
# Critical for Fleet Commander workflow (switch context only when notified)
#

TASK_NAME="$1"
TASK_STATUS="$2"
INSTANCE_NUMBER="$3"

# Determine icon based on status
if [[ "$TASK_STATUS" == "success" ]]; then
  ICON="✅"
  URGENCY="normal"
else
  ICON="❌"
  URGENCY="critical"
fi

# Create notification message
MESSAGE="${ICON} Task Complete: $TASK_NAME"

# Send notification based on platform
send_notification() {
  # macOS
  if command -v osascript &> /dev/null; then
    osascript -e "display notification \"$MESSAGE\" with title \"Claude Code - Instance $INSTANCE_NUMBER\" sound name \"Glass\""
    return 0
  fi

  # Linux with notify-send
  if command -v notify-send &> /dev/null; then
    notify-send --urgency="$URGENCY" "Claude Code - Instance $INSTANCE_NUMBER" "$MESSAGE"
    return 0
  fi

  # Linux with zenity
  if command -v zenity &> /dev/null; then
    zenity --notification --text="$MESSAGE"
    return 0
  fi

  # Fallback: terminal bell + echo
  echo -e "\a"
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "$MESSAGE"
  echo "Instance: $INSTANCE_NUMBER"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
}

# Send the notification
send_notification

# Log to file for later review
LOG_FILE=".claude/task-log.txt"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Instance $INSTANCE_NUMBER: $TASK_NAME - $TASK_STATUS" >> "$LOG_FILE"

exit 0
