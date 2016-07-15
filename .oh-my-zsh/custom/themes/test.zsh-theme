if [[ $USER = "vivek" ]]; then
    local user='%{$terminfo[bold]$fg[red]%}vivek%{$reset_color%}'
else
    local user='%{$terminfo[bold]$fg[green]%}tamil%{$reset_color%}'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'

function foo() {
  if [[ -d .git ]]; then
    echo "some text $(git_prompt_info)%{$reset_color%}"
  else
    echo "nothing"
  fi
}

PROMPT="╭─${user} ${current_dir} $(foo)
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
