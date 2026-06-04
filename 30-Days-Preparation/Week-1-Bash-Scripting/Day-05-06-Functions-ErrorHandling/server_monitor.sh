#!/bin/bash

# ==========================================
# 🛡️ Strict Error Handling Setup
# ==========================================
# -e: Exit immediately if a pipeline, list, or compound command returns a non-zero status.
# -u: Treat unset variables and parameters as an error when performing parameter expansion.
# -o pipefail: The return value of a pipeline is the status of the last command to exit with a non-zero status.
set -euo pipefail

# ==========================================
# 🧹 Trap for Cleanup
# ==========================================
# A temporary log file for demonstration
TEMP_LOG="/tmp/monitoring_$$.log"

# The cleanup function that runs when the script exits (normally or via error)
cleanup() {
    echo "🧹 [Cleanup] Removing temporary files..."
    rm -f "$TEMP_LOG"
}

# 'trap' catches signals. EXIT means it runs when the script finishes.
trap cleanup EXIT

# ==========================================
# 🛠️ Helper Functions
# ==========================================

# Function to print error messages to stderr
log_error() {
    # Using 'local' ensures the variable is only accessible within this function
    local msg="$1"
    echo -e "❌ [ERROR] $msg" >&2
}

# Function to print info messages
log_info() {
    local msg="$1"
    echo -e " [INFO] $msg"
}

# Function simulating a server health check
check_server() {
    local server_name="$1"
    log_info "Pinging $server_name..."
    
    # Simulating a failure for a specific server
    if [[ "$server_name" == "db-server" ]]; then
        log_error "Failed to reach $server_name!"
        return 1 # Return a non-zero exit status to indicate failure
    fi
    
    echo "Server $server_name is online." > "$TEMP_LOG"
    log_info "$server_name is healthy."
    return 0 # Success
}

# ==========================================
# 🚀 Main Execution
# ==========================================

log_info "Starting server health checks..."

# 1. Checking a healthy server
check_server "web-server"

# 2. Checking a failing server
# Because we have 'set -e', if check_server returns 1, the script would normally exit immediately!
# To prevent this and handle the error gracefully, we use '||' (OR).
check_server "db-server" || {
    log_error "Critical Database is down! We caught the error gracefully."
    # We could send an alert here instead of letting the script crash
}

# 3. Demonstrating 'set -u' (Uncomment the line below to see it in action)
# echo "Trying to access an undefined variable: $NON_EXISTENT_VAR"

log_info "Script execution finished successfully!"
