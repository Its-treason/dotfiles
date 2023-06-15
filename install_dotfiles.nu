#!/usr/bin/env nu

echo "This script will install all dotfiles."
echo "Existing files will be overriden! Waiting 10 seconds..."
echo ""
sleep 10sec

cd home

# First create all config directories
let dirs = (glob -F ** | each { $in | str substring (($env.PWD | str length) + 1)..($in | str length) } | skip 1)

$dirs | each { |$dir|
  echo $"mkdir ($env.HOME)/($dir)"
  mkdir $"($env.HOME)/($dir)"
}

# Collect all files and copy them to the right destination
let files = (glob -D ** | each { $in | str substring (($env.PWD | str length) + 1)..($in | str length) } | skip 1)
$files | each { |$file|
  echo $"cp ($env.PWD)/($file) ($env.HOME)/($file)"
  cp $"($env.PWD)/($file)" $"($env.HOME)/($file)"
}

