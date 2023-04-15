alias docker-composer = docker compose

alias dcd = docker compose -f docker-compose.development.yml
alias dcp = docker compose -f docker-compose.production.yml
alias dcq = docker compose -f docker-compose.qa.yml

alias cov = google-chrome build/coverage/index.html

alias ll = ls -la

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
  git commit -m $"($prefix): ($message)";
}
