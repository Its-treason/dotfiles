def "parse vars" [] {
  $in | from csv --noheaders --no-infer | rename 'op' 'name' 'value'
}

def --env "update-env" [] {
  for $var in $in {
    if $var.op == "set" {
      if ($var.name =~ '(?i)^path$') {
        $env.PATH = ($var.value | split row (char esep))
      } else {
        load-env {($var.name): $var.value}
      }
    } else if $var.op == "hide" and $var.name in $env {
      hide-env $var.name
    }
  }
}
export-env {
  
  'hide,ANSIBLE_GATHERING,
hide,ANSIBLE_REMOTE_USER,
hide,COMPOSER_IGNORE_PLATFORM_REQS,
set,PATH,/home/tschuenemann/.local/bin:/home/tschuenemann/.local/bin:/home/tschuenemann/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/usr/local/go/bin:/home/tschuenemann/.lmstudio/bin:/home/tschuenemann/.lmstudio/bin:/usr/local/go/bin:/home/tschuenemann/.lmstudio/bin:/home/tschuenemann/.lmstudio/bin:/home/tschuenemann/.local/share/JetBrains/Toolbox/scripts:/home/tschuenemann/.local/share/JetBrains/Toolbox/scripts:/home/tschuenemann/.local/share/mise/shims:/home/tschuenemann/.config/composer/vendor/bin/:/home/tschuenemann/.yarn/bin:/home/tschuenemann/.cargo/bin:/home/tschuenemann/.bun/bin/:/home/tschuenemann/.local/bin
hide,MISE_SHELL,
hide,__MISE_DIFF,
hide,__MISE_SESSION,' | parse vars | update-env
  $env.MISE_SHELL = "nu"
  let mise_hook = {
    condition: { "MISE_SHELL" in $env }
    code: { mise_hook }
  }
  add-hook hooks.pre_prompt $mise_hook
  add-hook hooks.env_change.PWD $mise_hook
}

def --env add-hook [field: cell-path new_hook: any] {
  let field = $field | split cell-path | update optional true | into cell-path
  let old_config = $env.config? | default {}
  let old_hooks = $old_config | get $field | default []
  $env.config = ($old_config | upsert $field ($old_hooks ++ [$new_hook]))
}

export def --env --wrapped main [command?: string, --help, ...rest: string] {
  let commands = ["deactivate", "shell", "sh"]

  if ($command == null) {
    ^"/home/tschuenemann/.cargo/bin/mise"
  } else if ($command == "activate") {
    $env.MISE_SHELL = "nu"
  } else if ($command in $commands) {
    ^"/home/tschuenemann/.cargo/bin/mise" $command ...$rest
    | parse vars
    | update-env
  } else {
    ^"/home/tschuenemann/.cargo/bin/mise" $command ...$rest
  }
}

def --env mise_hook [] {
  ^"/home/tschuenemann/.cargo/bin/mise" hook-env -s nu
    | parse vars
    | update-env
}

