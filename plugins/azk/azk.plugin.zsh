alias adoctor='azk doctor'
alias ainfo='azk info'
alias alogs='azk logs -f'
alias areload='azk reload'
alias arestart='azk restart'
alias ascale='azk scale'
alias astart='azk start'
alias astatus='azk status'
alias astop='azk stop'

# Azk Agent
alias aastatus='azk agent status'
alias aastart='azk agent start'
alias aastop='azk agent stop'

function ashell () {
  local system_name=$1
  shift
  local command="$*"

  if [[ -n $command ]]; then
	  azk shell $system_name -c $command
	else
		azk shell $system_name
	fi
}
