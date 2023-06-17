#!/usr/bin/env nu

print "This script will install all dotfiles."
print "Existing files will be overriden! Waiting 5 seconds..."
print ""
sleep 5sec

cd home

# First create all config directories
let dirs = (glob -F ** | each { $in | str substring (($env.PWD | str length) + 1)..($in | str length) } | skip 1)
$dirs | each { |$dir|
  print $"mkdir ($env.HOME)/($dir)"
  mkdir $"($env.HOME)/($dir)"
}

# Collect all files and copy them to the right destination
let files = (glob -D ** | each { $in | str substring (($env.PWD | str length) + 1)..($in | str length) } | skip 1)
$files | each { |$file|
  if ($file | str contains ".git") {
    continue;
  }

  print $"cp ($env.PWD)/($file) ($env.HOME)/($file)"
  cp $"($env.PWD)/($file)" $"($env.HOME)/($file)"
}

