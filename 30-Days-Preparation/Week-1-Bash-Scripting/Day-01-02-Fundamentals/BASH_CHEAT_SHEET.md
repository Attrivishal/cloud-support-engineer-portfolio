# 🚀 Bash Scripting Cheat Sheet & Memory Guide

This guide is designed to help you quickly recall the most important Bash concepts for interviews and daily cloud work.

---

## 🧠 1. The "Cheat Codes" (Memory Tricks)
If you forget everything else, remember these tricks to figure it out on the fly:

| Concept | Memory Aid |
| :--- | :--- |
| **No `$` for setting** | **Set** it Straight (No `$`) |
| **`$` for getting** | **S**ee the value (`$`) |
| **`$?`** | `?` = "How did it go?" (Exit status: 0=Success, 1=Fail) |
| **`$#`** | `#` = The **number/count** of arguments |
| **`$@`** | `@` = **All** arguments as separate items (like `@everyone`) |
| **`$*`** | `*` = **Wildcard**, everything mashed into one single string |
| **`$(cmd)`** | `($)` = Dollar + Parentheses = Capture command output |
| **`set -e`** | **e** for **E**xit on **E**rror |
| **`set -u`** | **u** for **U**ndefined variable error |

---

## 🛡️ 2. The Golden Rules & Safety

### The "Safety Triple" (Start every script with this!)
```bash
#!/bin/bash
set -euo pipefail
```
- `-e`: Exits immediately if any command fails (prevents disaster).
- `-u`: Exits if you try to use a variable that doesn't exist.
- `-o pipefail`: Ensures pipes (`|`) don't hide errors.

### The Quoting Rule
**Always use double quotes around variables!**
```bash
✅ echo "$name"   # Safe!
❌ echo $name     # Dangerous! Can break if the name has spaces.
```
- `"double"`: Variables expand (`"Hello $name"` → `Hello John`)
- `'single'`: Literal, NO expansion (`'Hello $name'` → `Hello $name`)

---

## 📦 3. Variable Mastery

### Setting and Getting
```bash
# ✅ CORRECT (No spaces around =)
name="John"

# ❌ WRONG (Spaces break it)
name = "John"

# Accessing
echo "$name"      # Normal access
echo "${name}Doe" # Braced access (Use when text touches the variable)
```

### Local vs Global (Functions)
Always use `local` inside functions unless you specifically want to change a global variable.
```bash
my_function() {
    local my_var="I only exist in here"
}
```

### Default Values (Common in Cloud Configs)
```bash
region="${AWS_REGION:-us-east-1}"         # Use default if not set
config="${CONFIG_PATH:?Path is required}" # Crash script if not set
```

---

## ✂️ 4. Quick String Operations

| Goal | Syntax | Example | Result |
| :--- | :--- | :--- | :--- |
| **Length** | `${#var}` | `${#name}` | `4` (Length of "John") |
| **Substring** | `${var:start:length}`| `${name:0:2}` | `Jo` |
| **Remove Extension**| `${var%.*}` | `file.txt` | `file` |
| **Get Filename** | `${var##*/}` | `/path/to/file.txt`| `file.txt` |
| **Replace** | `${var/old/new}` | `${text/red/blue}` | Replaces first "red" with "blue" |
| **UPPERCASE** | `${var^^}` | `${name^^}` | `JOHN` |
| **lowercase** | `${var,,}` | `${name,,}` | `john` |

---

## 🧮 5. Arithmetic (Math)
Use double parentheses `(( ))` for math.
```bash
count=5
((count++))              # Add 1
result=$((count * 2))    # Multiply and store
```

---

## 📚 6. Arrays (Lists of Items)

**Standard Array:**
```bash
servers=("web01" "web02" "db01")

echo "${servers[0]}"     # Get first item: web01
echo "${servers[@]}"     # Get ALL items
echo "${#servers[@]}"    # Get total count (3)

servers+=("cache01")     # Add an item
```
