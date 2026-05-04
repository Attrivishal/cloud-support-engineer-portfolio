# 📚 Learning Log: Day 03 - 04: Loops & Advanced Conditionals

## 🎯 Objectives
- Understand why loops are critical for repetitive cloud tasks (like checking 50 servers).
- Master `for` loops, `while` loops, and `until` loops.
- Learn advanced conditionals (`case` statements and compound `if` logic).
- Practice writing scripts that automate multi-step processes.

## 📝 Concepts Learned

### 1. For Loops (The Multi-Tasker)
- **Standard Loop:** Iterates over a list of items.
  - *Example:* `for user in "john" "jane" "bob"; do echo "Creating user: $user"; done`
- **Range Loop:** Uses curly braces `{start..end}`.
  - *Example:* `for i in {1..5}; do echo "Server-$i"; done`
- **C-Style Loop:** For when you need precise math.
  - *Example:* `for ((i=0; i<10; i++)); do echo $i; done`

### 2. While Loops (The Condition Watcher)
-Using WHILE LOOP when don't know when to stop,  Runs as long as a condition is **TRUE**.
- **Common use case:** Monitoring a process until it finishes or reading a file line by line.
- *Example:*
  ```bash
  count=1
  while [ $count -le 5 ]; do
      echo "Attempt $count"
      ((count++))
  done
  ```

### 3. Case Statements (The Clean Alternative)
- Used instead of long `if-elif-elif-else` chains. It's much cleaner for menus or checking specific patterns.
- *Example:*
  ```bash
  case "$ENVIRONMENT" in
      "prod") echo "Deploying to Production..." ;;
      "dev")  echo "Deploying to Development..." ;;
      *)      echo "Unknown Environment!" ;;
  esac
  ```

### 4. String Comparison Flags (Deep Dive)
When working with strings in Bash, these flags are essential for validating inputs or checking statuses.

| Flag | Condition | Returns True (0) when | Example |
| :--- | :--- | :--- | :--- |
| `-z` | Zero length | String is **empty** | `[ -z "$VAR" ]` |
| `-n` | Non-zero length | String **has characters** | `[ -n "$VAR" ]` |
| `=` | Equal | Strings are identical | `[ "$str1" = "$str2" ]` |
| `==` | Equal (Bash-specific)| Same as above | `[ "$str1" == "$str2" ]` |
| `!=` | Not equal | Strings are different | `[ "$str1" != "$str2" ]` |
| `<` | Less than | String1 comes before String2 | `[[ "$str1" < "$str2" ]]` |
| `>` | Greater than | String1 comes after String2 | `[[ "$str1" > "$str2" ]]` |

> [!TIP]
> Always use double brackets `[[ ... ]]` when using `<` or `>` to prevent Bash from treating them as "redirect" symbols.

### 5. Advanced Logic (`&&` and `||`)
- `&&` (AND): Run the second command ONLY if the first one succeeds.
  - *Example:* `mkdir logs && cd logs`
- `||` (OR): Run the second command ONLY if the first one fails.
  - *Example:* `ls non_existent_file || echo "File not found!"`

## 🛠 Hands-on / Practical 
- [ ] Create a script that pings a list of 5 websites using a `for` loop.
- [ ] Write a script that asks for a username and uses `-z` to check if they left it blank.
- [ ] Create a script that counts down from 10 to 1 using a `while` loop.
- [ ] Write a "System Menu" script using `case` that lets the user choose to see: (1) Disk Space, (2) Memory, (3) Uptime.

## ❓ Outstanding Questions
- When should I use `until` instead of `while`?
- How do I break out of a loop early if an error occurs?

## ✅ Action Items
- [x] Review fundamentals from Day 01-02.
- [ ] Complete the "System Menu" script.
- [ ] Practice nested loops (loop inside a loop).

