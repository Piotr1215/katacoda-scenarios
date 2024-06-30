## File Structure:

## Content:

intro.md:
```markdown
# Bash Scripting: Building a File Creator Script

In this scenario, you'll learn how to create a bash script step by step. We'll build a script that greets the user, asks how many files to create, and then creates those files.

You'll learn about:
- Basic script structure and strict mode
- Functions in bash
- Command-line arguments and error handling
- User input and validation
- Conditional logic with case statements
- Loops, arrays, and file creation

Let's get started with setting up our script!
```

step1.md:
```markdown
# Step 1: Setting Up the Script

Let's start by creating the basic structure of our script with strict mode.

```bash
cat << 'EOF' > file_creator.sh
#!/usr/bin/env bash

# Set strict mode
set -euo pipefail
EOF

chmod +x file_creator.sh
```{{exec}}

The `set` command with these options enables strict mode:
- `-e`: Exit immediately if a command exits with a non-zero status.
- `-u`: Treat unset variables as an error when substituting.
- `-o pipefail`: The return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status.

This helps catch errors early and prevents many common shell scripting pitfalls.
```

step2.md:
```markdown
# Step 2: Adding a Function

Now let's add a function to print headers. Functions allow you to group commands and reuse code.

```bash
cat << 'EOF' >> file_creator.sh

# Function definition
print_header() {
    echo "==== $1 ===="
}

# Test the function
print_header "Welcome"
echo "Hello, welcome to our bash script!"
EOF

./file_creator.sh
```{{exec}}

Functions in bash allow you to group commands together and call them multiple times. This improves code readability and reusability.
```

step3.md:
```markdown
# Step 3: Handling Command Line Arguments

Let's modify our script to accept a name as a command-line argument and add basic error handling.

```bash
cat << 'EOF' >> file_creator.sh

# Assign command line arguments to variables
name="${1:-}"
# We quote variables to prevent word splitting and glob expansion
# ${1:-} means use $1 if set, otherwise use empty string

# Basic error handling
if [[ $# -eq 0 ]]; then
    echo "Error: Name is required."
    echo "Usage: $0 <name>"
    exit 1
fi
# $# is a special variable that holds the number of arguments
# [[ ]] is a bash keyword for conditional expressions, more powerful than single []
# Exit codes: 0 means success, any non-zero value indicates an error

print_header "Welcome"
echo "Hello, ${name}! Welcome to our bash script."
EOF

./file_creator.sh
./file_creator.sh Alice
```{{exec}}

This step introduces command-line argument handling and basic error checking. We use parameter expansion to safely handle potentially unset variables.
```

step4.md:
```markdown
# Step 4: Adding User Input with Validation

Now, let's add user input to ask how many files to create, with input validation.

```bash
cat << 'EOF' >> file_creator.sh

# Input with validation
while true; do
    read -p "How many files do you want to create? (0-5): " num_files
    if [[ "$num_files" =~ ^[0-5]$ ]]; then
        break
    else
        echo "Please enter a number between 0 and 5."
    fi
done
# =~ tests against a regular expression
# This loop continues until valid input is received

echo "You chose to create $num_files files."
EOF

./file_creator.sh Alice
```{{exec}}

This step demonstrates how to get user input and validate it using a while loop and regular expressions. The script will keep asking for input until a valid number is provided.
```

step5.md:
```markdown
# Step 5: Adding Conditional Logic

Let's add a case statement to provide different messages based on the number of files.

```bash
cat << 'EOF' >> file_creator.sh

# Conditional operators and case statement
case $num_files in
    0)
        echo "No files will be created."
        ;;
    [1-3])
        echo "Creating a few files..."
        ;;
    [4-5])
        echo "Creating many files..."
        ;;
esac
# Case statements are useful for multiple conditions on a single variable
EOF

./file_creator.sh Alice
```{{exec}}

Case statements in bash provide a clean way to handle multiple conditions for a single variable. They're often more readable than complex if-else structures for certain types of conditional logic.
```

step6.md:
```markdown
# Step 6: Implementing File Creation

Finally, let's implement the actual file creation using an array and a loop.

```bash
cat << 'EOF' >> file_creator.sh

# Array and loop for file creation
files=()
for ((i = 1; i <= num_files; i++)); do
    filename="file_$i.txt"
    echo "This is file number $i" > "$filename"
    files+=("$filename")
done
# Arrays can store multiple values
# This loop uses C-style syntax, common in many programming languages

# String manipulation
print_header "Created Files"
for file in "${files[@]}"; do
    echo "${file##*/}" # Remove path, show only filename
done
# ${files[@]} expands to all array elements
# ${file##*/} is parameter expansion, removing everything up to the last '/'

print_header "Script Completed"
EOF

./file_creator.sh Alice
ls -l file_*.txt
```{{exec}}

This final step introduces arrays, C-style for loops, and string manipulation in bash. We create files based on user input, store their names in an array, and then display the created files using parameter expansion to show only the filenames.
```

finish.md:
```markdown
# Congratulations!

You've successfully created a bash script that:
- Uses strict mode for error catching
- Defines and uses functions
- Handles command-line arguments
- Validates user input
- Uses conditional logic with case statements
- Creates files based on user input using loops and arrays
- Manipulates strings and file paths

Here's a summary of what you've learned:
- How to structure a bash script with proper error handling
- Using functions to organize and reuse code
- Handling command-line arguments and providing usage information
- Input validation techniques using loops and regular expressions
- Conditional statements with case for multiple conditions
- Working with arrays and loops for file creation
- String manipulation and parameter expansion in bash

Feel free to modify the script further or use it as a foundation for more complex bash scripts!
```
