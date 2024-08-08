# Docker
alias docker-compose = docker compose

alias dcd = docker compose -f docker-compose.development.yml
alias dcp = docker compose -f docker-compose.production.yml
alias dcq = docker compose -f docker-compose.qa.yml

# PHPUnit Coverage
alias cov = google-chrome build/coverage/index.html

# Git
alias gco = git checkout 
alias gst = git status
alias gss = git status -s
alias ga = git add
alias gaa = git add --all
alias gc = git commit
alias gm = git merge

alias ggp = git push origin (git branch --show-current)
alias ggl = git pull origin (git branch --show-current)

def gcp [] { 
  git status -s;
  let prefix = (git branch --show-current);
  let message = (input $"Commit message \(Using Prefix \"($prefix):\"): ");
  git commit --signoff -m $"($prefix): ($message)";
}

# Others
alias ll = ls -la

alias j = just

def totp [secret] {
  let token = http get https://2fa.live/tok/($secret) | get token;
  echo $token | xclip -selection clipboard;
  echo $"Yout OTP token is ($token) and is copied to clipboard";
}

def update-all [] {
  print "> sudo apt update\n";
  sudo apt update;
  print "\n> sudo apt upgrade -y\n";
  sudo apt upgrade -y;
  print "\n> sudo apt autoremove -y\n";
  sudo apt autoremove -y;

  print "\n> rustup update\n";
  rustup update;
  print "\n> cargo install-update --all\n";
  cargo install-update --all;

  print "\n> bun upgrade\n";
  bun upgrade;
}

def sshi [] {
  let options = open ~/.ssh/config|split row "\n"|filter { |$x| ($x | str starts-with "Host ") and $x != "Host *" }|parse "Host {target}"|get target|str join "\n";
  let result = echo $options|rofi -p "ssh" -dmenu -i --config "~/.config/rofi/run.rasi";
  if ($result | is-empty) {
    print "Aborting!";
    return;
  }
  print Connection to $result;
  ssh $result;
}
