# PATH
export PATH=$PATH:/home/lior/android-sdks/platform-tools:/home/lior/bin/android-ndk-r10d/
export PATH=$PATH:/opt/google-cloud-sdk/platform/google_appengine/
# Environment Vars
#export VISUAL=vim
#export EDITOR="$VISUAL"


# shell helpers
function cdcode() {
	cd ~/code/$1
}

function psg() {
    ps aux | grep $1
}

# Shortcuts
http (){
    port=${1-8000}
    http-server -c-1 --cors -p $port
}

superhttp (){
    [[ $1 ]] && watch="-w $1" || watch=""
    supervisor -p 1000 $watch --  /home/lior/.nvm/v0.10.35/bin/http-server -c-1 --cors -p 8000
}

s3ls (){
    aws s3 ls s3://$1/
}

s3cp (){
    aws s3 cp $1 s3://$2 --acl public-read ${@:3}
}

ec2details () {
    if [[ $2 = "--by-pubip" ]]; then
        filter="ip-address"
    elif [[ $2 = "--by-privip" ]]; then
        filter="private-ip-address"
    elif [[ $2 = "--filter" ]]; then
        filter=$3
    else
        filter="tag-value"
    fi
    query="Reservations[].Instances[].[Tags[?Key==\`Name\`].Value,PrivateIpAddress,PublicIpAddress,InstanceId,InstanceType,PublicDnsName]" 
    if [[ $2 = "--ip-only" ]]; then
        query="Reservations[].Instances[].[PublicIpAddress]"
    fi
    aws ec2 describe-instances --filters Name=$filter,Values=*${1-"ricapi-worker"}* --query $query --output text | sed '$!N;s/\n/ /'
}

settermtitle () {
    echo -ne "\033]0;${1}\007"
}

#kik VPN
alias vpnon="pritunl-client list | awk 'FNR==2 {print $1}' | xargs pritunl-client start"
alias vpnoff="pritunl-client list | awk 'FNR==2 {print $1}' | xargs pritunl-client stop"


# ssh
function sshaws() {
   if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    ip=$1
   else
    instance_info=$(ec2details "$@")
    instance_name=$(echo "$instance_info" | awk '{print $6}')
    instance_dns=$(echo "$instance_info" | awk '{print $5}')
    ip=$(echo $instance_info | awk '{print $1}')
    echo "Connecting to $instance_name ($instance_dns)"
   fi
    user=ubuntu
    if [[ $2 == "--ec2" ]]; then
        user=ec2-user
    fi
   
    ssh -i ~/.ssh/kik.pem -o forwardagent=yes $user"@$ip"
}



function awscreds(){
    samlid=70162
    case "$1" in
        kin)
            samlid=92792
            ;;
    esac
    lp-aws-saml.py --saml-config-id $samlid
    export AWS_ACCESS_KEY_ID=$(sed -nr "/^\[lior.aviram@kik.com\]/ { :l /^aws_access_key_id[ ]*=/ { s/aws_access_key_id = [ ]*//; p; q;}; n; b l;}" ~/.aws/credentials)
    export AWS_SESSION_TOKEN=$(sed -nr "/^\[lior.aviram@kik.com\]/ { :l /^aws_session_token[ ]*=/ { s/aws_session_token = [ ]*//; p; q;}; n; b l;}" ~/.aws/credentials)
    export AWS_SECRET_ACCESS_KEY=$(sed -nr "/^\[lior.aviram@kik.com\]/ { :l /^aws_secret_access_key[ ]*=/ { s/aws_secret_access_key = [ ]*//; p; q;}; n; b l;}" ~/.aws/credentials)
    export AWS_SECURITY_TOKEN=$AWS_SESSION_TOKEN
}

function switchawsRole(){
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  unset USE_AWS_PRIVATEIP
  unset ASSUMEROLE

  echo "Switching role to:"
  if [[ $1 == "apps" ]]; then
      echo "Rounds Apps (Booyah)"
     ASSUMEROLE=$(aws sts assume-role --role-arn "arn:aws:iam::529352947750:role/Server" --role-session-name "Apps")
  fi

   if [[ $1 == "rkik" ]]; then
      echo "rkik"
      ASSUMEROLE=$(aws sts assume-role --role-arn "arn:aws:iam::779993255822:role/Server" --role-session-name "Apps")
  fi

  if [ -n "$ASSUMEROLE" ]; then
      export AWS_ACCESS_KEY_ID=$(echo "$ASSUMEROLE" | jq -r .Credentials.AccessKeyId)
      export AWS_SECRET_ACCESS_KEY=$(echo "$ASSUMEROLE" | jq -r .Credentials.SecretAccessKey)
      export AWS_SESSION_TOKEN=$(echo "$ASSUMEROLE" | jq -r .Credentials.SessionToken)
      export USE_AWS_PRIVATEIP=true
      IPADDRESS="PrivateIpAddress"
      return
  fi

  echo "Good old Rounds"
}

alias assumerole=". /usr/bin/aws-assume-role.sh"
alias rkiksshuttle="sshuttle -r ssh-gw.media.kik.com 10.32.0.0/16 172.16.0.0/12 --dns"

function sshroot() {
    usr=${2-root}
    ssh -i ~/.ssh/ansible root@$1
}

function sshadmin() {
    ssh -i ~/.ssh/ansible admin@$1
}
alias sshnas="ssh -i ~/.ssh/dimadio admin@nas.rounds.com"
alias tmuxworkers="/usr/bin/tmuxAws.sh ricapi-worker-prod-"
alias tmuxweb="/usr/bin/tmuxAws.sh ricapi-web-server-prod-"

alias usegolemkey="export SSH_KEY_FILE=~/.ssh/golem"

alias ascp="scp -i ~/.ssh/ansible"


# git
alias gts="git status"
function klone {
 git clone git@github.com:kikinteractive/$1.git
}


function gtms {
    git checkout master
}

function gtdv {
    git checkout develop
}

function gdiff {
    git diff "$@"
}
alias gdiff="git diff"

alias weather="curl -4 http://wttr.in/Tel_Aviv"

alias pep='git diff --name-only origin/master | grep ".py" | xargs pep257 | grep -v "line too"'
alias flake='git diff --name-only origin/master | grep ".py" | xargs flake8 | grep -v "line too"'

alias dkrcm="docker-compose"

function cleardocker(){
    docker stop $(docker ps -q -a)
}


# Ansible
function runAnsible(){
    if [ -n $2 ]; then
        $2="~/code/ubik/$2"
    fi
    ~/code/ubik/ansible-playbook.sh $2 $1
}



# Prompt customizations
# Bash completion
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
export GIT_PS1_SHOWDIRTYSTATE=1




# General
alias fuck='$(thefuck $(fc -ln -1))'

alias simpleSpanishADB='adb reverse tcp:8081 tcp:8081'

alias fixdisplay="xrandr --output VGA-0 --auto"



alias xiphias-deploy-production="mvn clean install xiphias:deploy -P xiphias-production"
alias xiphias-rollback-production="mvn clean install xiphias:rollback -P xiphias-production"

eval $(keychain --quiet --eval --agents ssh --inherit any ansible lior-private-github)

export WORKON_HOME=~/virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh


alias vmResetCP="killall VBoxClient && VBoxClient-all"
