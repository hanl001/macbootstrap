
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


function add_ssh_keys() {
    # Will load ~/.ssh/id_rsa
    ssh-add
    # You also can add the other keys here
    # For example, add your GitHub key: ssh-add ~/.ssh/github
}

SSH_ENV="$HOME/.ssh/environment"
function _start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    add_ssh_keys
}

function start_ssh_agent() {
    # Source SSH settings, if applicable
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        #ps ${SSH_AGENT_PID} doesn't work under cywgin
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            _start_agent;
        }
    else
        _start_agent;
    fi
}

function set_alias() {
    alias ll='ls -l'
    alias ssh='ssh -A'
}

start_ssh_agent
set_alias