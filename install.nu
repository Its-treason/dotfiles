cd home

let dirs = (glob -F ** | str substring $"(($env.PWD | str length) + 1)," | skip 1)

$dirs | each { |$dir|
  echo $"mkdir ($env.HOME)/($dir)"
}

let files = (glob -D ** | str substring $"(($env.PWD | str length) + 1)," | skip 1)

$files | each { |$file| 
  echo $"link ($env.PWD)/($file) ($env.HOME)/($file)"
}

