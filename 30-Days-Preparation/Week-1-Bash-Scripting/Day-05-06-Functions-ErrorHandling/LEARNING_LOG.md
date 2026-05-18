# 📚 Learning Log: Day 05-06 Functions & Error Handling

## 🎯 Objectives
- Master the creation and usage of functions in Bash.
- Understand how to pass arguments and return values in functions.
- Learn robust error handling techniques to make scripts production-ready.
- Understand the use of `set` options (`set -e`, `set -u`, `set -o pipefail`) and `trap`.

## 📝 Concepts Learned

### 1. Bash Functions
Functions help modularize code, making it reusable, readable, and easier to maintain.
- **Definition Syntax**:
  ```bash
  function_name() {
      # commands
  }
  # OR
  function function_name {
      # commands
  }
  ```
- **Local Variables**: Use the `local` keyword inside functions to prevent variable scoping issues (`local my_var="value"`).
- **Arguments**: Accessed using `$1`, `$2`, etc., just like script arguments, but they are local to the function.
- **Return Values**:
  - `return <status_code>`: Returns an exit status (0-255). 0 means success.
  - `echo "value"`: To return a string or data, you `echo` it and capture it via command substitution (`result=$(my_function)`).

### 2. Error Handling
Robust scripts anticipate failures and handle them gracefully.
- **Exit Status (`$?`)**: Every command returns an exit status. `0` is success, non-zero is failure.
- **The "Strict Mode" (`set -euo pipefail`)**:
  - `set -e`: Exits the script immediately if any command returns a non-zero status.
  - `set -u`: Exits if an undefined variable is referenced.
  - `set -o pipefail`: Prevents errors in a pipeline from being masked. If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline.
- **`trap` Command**: Executes a command when the script receives a specific signal (like `SIGINT` or `EXIT`). Useful for cleaning up temporary files before the script exits.
  ```bash
  trap 'rm -f /tmp/mytempfile' EXIT
  ```

## 🛠 Hands-on / Practical 
Created a bash script `server_monitor.sh` demonstrating:
1. **Strict Error Handling** with `set -euo pipefail`.
2. **Helper Functions** (`log_info`, `log_error`) to standardize output.
3. **Graceful Error Catching** using `||` when a function fails, preventing the script from exiting abruptly due to `set -e`.
4. **Cleanup Automation** using `trap cleanup EXIT`.

To run the script:
```bash
chmod +x server_monitor.sh
./server_monitor.sh
```

## ⚠️ Challenges & Troubleshooting
- **Issue**: Forgetting that function arguments shadow script arguments. Inside `my_function`, `$1` is the first argument passed to the function, NOT the script.
- **Solution**: Always explicitly pass needed script arguments into functions or use clearly named global variables (though local variables and passing arguments are preferred).

## ❓ Outstanding Questions
- How to handle errors for specific commands while using `set -e` without causing the whole script to exit? (Hint: Use `|| true` or `|| handle_error`).

## ✅ Action Items
- [x] Review notes on Functions and Error Handling
- [ ] Create a practical script using functions and strict error handling
- [ ] Push code/scripts to GitHub
