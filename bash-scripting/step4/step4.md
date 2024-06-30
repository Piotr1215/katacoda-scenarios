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
