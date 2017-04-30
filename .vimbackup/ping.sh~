_codeDirComplete(){
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -S "/" -W "$(find ~/code -maxdepth 1 -type d | xargs -n 1 basename)" -- $cur) )
}
complete -o nospace -F _codeDirComplete cdcode
