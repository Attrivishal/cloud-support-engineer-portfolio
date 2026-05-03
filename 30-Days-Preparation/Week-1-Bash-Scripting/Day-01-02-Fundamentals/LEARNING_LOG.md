# 📚 Learning Log: Day 01 - Absolute Basics of Bash Scripting

## 🎯 Objectives
- Understand what Bash is and why Cloud Engineers use it.
- Understand what a script is and why it's necessary.
- Learn the very first building blocks of writing a script from absolute scratch.

## 📝 Concepts Learned (Starting from Zero)

### 1. What is Bash?
- **Definition:** Bash (Bourne Again Shell) is a command-line interpreter. Think of it as a translator between you and the Linux/Mac operating system. 
- **Why use it?** Instead of clicking buttons with a mouse in a graphical interface (GUI), you type commands to tell the computer exactly what to do. It is much faster, uses less memory, and is how almost all cloud servers (like AWS EC2 instances) are managed.

### 2. What is a Script?
- **Definition:** A script is simply a plain text file containing a list of Bash commands written in order.
- **Why use it?** If you have to create 100 users on a server, typing the command 100 times is boring and leads to mistakes. A script allows you to write the command once, tell the computer to repeat it 100 times, and let the computer do the work in seconds. It is the absolute heart of **Automation**.

### 3. The Anatomy of a Script: Step-by-Step

#### Step A: The Shebang (`#!/bin/bash`)
- **What is it?** It is always the very first line of your script file.
- **Why use it?** It tells the computer, "Hey, use the Bash translator to read the rest of this file." Without it, the computer might try to read your file using the wrong program and crash.

#### Step B: Making the Script Runnable (Permissions)
- When you create a new text file, the computer assumes it's just text (like a diary entry) to protect you from accidentally running viruses.
- **How to fix:** You must explicitly tell the computer, "This file is a safe program, let me run it." You do this using the command `chmod +x filename.sh` (`+x` means add eXecute permission).

#### Step C: Storing Data (Variables)
- **What is it?** A variable is like a labeled cardboard box where you keep information to use later.
- **How to create one:** Write the box name, an equals sign, and the value. **No spaces allowed around the equals sign!** 
  - *Example:* `ROLE="Cloud Engineer"`
- **Why do we use the `$` symbol?** 
  - When you *create* the box, you just use the name: `ROLE="Cloud Engineer"`.
  - When you want to *open the box and look inside* to use the information, you MUST use the `$`. 
  - *Example:* `echo $ROLE` tells the computer: "Print whatever is inside the ROLE box." If you forget the `$`, the computer will literally just print the word "ROLE".

#### Step D: Getting Input from the Outside (Arguments)
- When you run a script, you can pass information to it right from the terminal. 
- *Example:* Instead of just running `./script.sh`, you run `./script.sh apple banana`
- Bash automatically creates secret boxes for these extra words:
  - `$1` contains the first word: "apple"
  - `$2` contains the second word: "banana"

#### Step E: Did it work? (The `$?` variable)
- Every time a command finishes, it silently leaves behind a number.
- `0` means it worked perfectly.
- Any other number (1, 2, etc.) means there was an error.
- **Why use it?** You check the `$?` variable to see if your last command was successful before moving on to the next one. This is how scripts know to stop if something goes wrong.

## 🛠 Hands-on / Practical 
*My First Script Checklist:*
1. Created a file in the terminal: `touch myscript.sh`
2. Opened the file and typed `#!/bin/bash` at the very top.
3. Created a variable: `NAME="Vishal"`
4. Added a command to use the variable: `echo "My name is $NAME"`
5. Saved and closed the file.
6. Made it runnable: `chmod +x myscript.sh`
7. Ran it by typing: `./myscript.sh`

## ❓ Outstanding Questions
- How do I make the script pause and wait for the user to type something on their keyboard? (Next topic to explore).

## ✅ Action Items
- [x] Understand what Bash and Scripts are from the ground up.
- [x] Understand the difference between creating a variable and using it with `$`.
- [ ] Practice writing a script with variables and running it in the terminal.
