#!/usr/bin/env nu

print "This script will collect all local dotfiles and copy them here."
print "Existing files will be overriden! Waiting 5 seconds..."
print ""
sleep 5sec

cd home

# These directories can be copied completely
let dirs = [
  ".config/nvim"
];
$dirs | each { |$dir|
  print $"cp -r ($env.HOME)/($dir)/* ($env.PWD)/($dir)"
  cp -r $"($env.HOME)/($dir)/*" $"($env.PWD)/($dir)"
}

# Collect all files and copy them from the local config dir into here
let files = (glob -D ** | each { $in | str substring (($env.PWD | str length) + 1)..($in | str length) } | skip 1)
$files | each { |$file|
  if ($file | str contains ".git") {
    continue;
  }

  if ($"($env.HOME)/($file)" | path exists) {
    print $"cp ($env.HOME)/($file) ($env.PWD)/($file)";
    cp $"($env.HOME)/($file)" $"($env.PWD)/($file)";
  } else {
    print $"Skipping: ($env.HOME)/($file) becuase it was deleted";
  }
}

