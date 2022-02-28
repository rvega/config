git_branch() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo " %{$fg[yellow]%}[$(git_current_branch)]%{$reset_color%}"
  fi
}

PROMPT='%{$fg_bold[green]%}%p %{$fg[green]%}%c$(git_branch) %{$fg_bold[green]%}> %{$reset_color%}'

# PROMPT="%{$fg_bold[green]%}%p %{$fg[green]%}%c > %{$reset_color%}"


