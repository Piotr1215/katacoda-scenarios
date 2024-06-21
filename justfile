default:
  just --list

copy_assets:
  # Validate initial JSON syntax
  @jq empty {{invocation_directory()}}/index.json || { echo "Invalid JSON format in index.json"; exit 1; }
  
  # Copy assets invocations
  @jq '.details.assets = input.details.assets' {{invocation_directory()}}/index.json /home/decoder/dev/katacoda-scenarios/template/template-index.json > tmp.json && mv tmp.json {{invocation_directory()}}/index.json
  
  # Add background and foreground scripts
  @jq '.details.intro = {"text": "intro.md", "background": "background.sh", "foreground": "foreground.sh"}' {{invocation_directory()}}/index.json > tmp.json && mv tmp.json {{invocation_directory()}}/index.json
  
