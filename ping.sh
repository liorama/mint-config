_pingSites(){
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "www.google.com api.rounds.com google.com www.facebook.com" -- $cur) )
}
complete -o nospace -F _pingSites ping
