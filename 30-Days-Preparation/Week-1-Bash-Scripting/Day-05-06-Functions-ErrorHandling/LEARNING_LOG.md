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
- **Passing Multiple Arguments**: 
  You pass arguments to a function just like you do to a script—separated by spaces. Inside the function, you access them using `$1` for the first argument, `$2` for the second, and so on. The special variable `$@` represents all arguments passed.
  ```bash
  create_user() {
      local username="$1"
      local role="$2"
      echo "Creating user $username with role $role"
  }
  
  # Calling the function with two arguments
  create_user "john_doe" "admin"
  ```
- **3 Ways to "Return" a Value from a Function**:
  Unlike Python or JavaScript, Bash functions do not return strings or objects directly. You have 3 main methods to get data back:
  1. **Using `return` (For Success/Failure Codes ONLY)**:
     You can only return an integer between `0` and `255`. By convention, `0` is success, and anything else is an error. You capture it using the `$?` variable immediately after the function call.
     ```bash
     is_admin() { return 0; } # 0 means true/success
     is_admin
     echo "Exit code: $?" 
     ```
  2. **Using `echo` and Command Substitution (For Strings/Data)**:
     This is the standard way to return actual text or data. You `echo` the result inside the function, and capture the function call in a variable using `$()`.
     ```bash
     get_greeting() {
         local name="$1"
         echo "Hello, $name!" # This is "returned"
     }
     # Capturing the echoed output into a variable
     my_greeting=$(get_greeting "Alice")
     echo "$my_greeting"
     ```
  3. **Modifying a Global Variable (For State Changes)**:
     Variables in Bash are global by default. If you don't use the `local` keyword, changing a variable inside a function changes it everywhere.
     ```bash
     FINAL_RESULT=""
     calculate_sum() {
         FINAL_RESULT=$(($1 + $2))
     }
     calculate_sum 5 10
     echo "The sum is: $FINAL_RESULT"
     ```

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
