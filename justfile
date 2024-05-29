default:
  just --list

copy_assets:
  @jq '.details.assets = input.details.assets' {{invocation_directory()}}/index.json /home/decoder/dev/katacoda-scenarios/vcluster/vcluster_introduction/index.json > tmp.json && mv tmp.json {{invocation_directory()}}/index.json
 
