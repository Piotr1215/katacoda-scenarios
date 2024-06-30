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
