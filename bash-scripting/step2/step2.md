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
