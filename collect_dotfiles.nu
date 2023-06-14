#!/usr/bin/env nu

echo "This script will collect all local dotfiles and copy them here."
echo "Existing files will be overriden! Waiting 10 seconds..."
echo ""
sleep 10sec

cd home

# These directories can be copied completely
let dirs = [
  ".config/nvim"
];
$dirs | each { |$dir|
  echo $"cp -r ($env.HOME)/($dir)/* ($env.PWD)/($dir)"
  cp -r $"($env.HOME)/($dir)/*" $"($env.PWD)/($dir)"
}

# Collect all files and copy them from the local config dir into here
let files = (glob -D ** | str substring $"(($env.PWD | str length) + 1)," | skip 1)
$files | each { |$file|
  if ($"($env.HOME)/($file)" | path exists) {
    echo $"cp ($env.HOME)/($file) ($env.PWD)/($file)"
    cp $"($env.HOME)/($file)" $"($env.PWD)/($file)"
  } else {
    echo $"Skipping: ($env.HOME)/($file) becuase it was deleted"
  }
}

