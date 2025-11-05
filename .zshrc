export
PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
LIBRARY_PATH="${LD_LIBRARY_PATH:+LD_LIBRARY_PATH:}/usr/local/opt/openssl$"
DEVTOOLS_PATH=~/vinted/dev-tools
ZSH="$HOME/.oh-my-zsh"
source "${DEVTOOLS_PATH:-$HOME/vinted/dev-tools}/bin/shell_function.sh"

plugins=(git ruby direnv)
ZSH_THEME="agnoster"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking

zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

kube-sh() {
    # Parses all arguments starting with --.
  while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
      v="${1/--/}"
      declare "$v"="$2"
      shift
    fi
   shift
  done

  # Sets the context to the --context argument or the current context.
  local CONTEXT=${context:-$(kubectl config current-context)}
  # Sets the namespace to the --namespace argument. [optional]
  local NAMESPACE=${namespace}
  # Sets the pod matcher to the --pod_matcher argument. Will be used for narrowing down search results. [optional]
  local POD_MATCHER=${pod_matcher}
  # Sets the command to the --command argument. Defaults to running bash.
  local COMMAND=${command:-/bin/bash}

  # Checks if fzf is installed.
  if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please run 'brew install fzf' and try again."
    return
  fi

  # Checks if you are logged in – if not, opens the login page.
  if ! kubectl --context "$CONTEXT" get --raw="/healthz" &>/dev/null; then
    open "https://auth.ingress.${CONTEXT}.k8s.vinted.com"
    return
  fi

  # Fuzzy search on namespaces if its not provided
  if [ -z ${NAMESPACE} ]; then
    NAMESPACE=$(kubectl --context "$CONTEXT" get namespace --no-headers | fzf --header 'Select namespace' | awk '{ print $1}')
  fi

  # Fuzzy search on running & ready pods
  local POD=$(kubectl --context "$CONTEXT" -n $NAMESPACE \
    get pod --no-headers \
    --sort-by=.status.startTime --field-selector=status.phase=Running \
    -o jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.status.conditions[?(@.type=='Ready')].status}{'\n'}{end}" \
    | grep "$POD_MATCHER" \
    | awk -F '\t' '$2=="True" { print $1}' \
    | fzf --query "$POD_MATCHER" --header 'Select active pod.' \
    | awk '{ print $1}')

  echo "Running $COMMAND in pod: $POD in [namespace: $NAMESPACE, context: $CONTEXT]"

  # Run the command on the specified pod
  kubectl --context "$CONTEXT" -n "$NAMESPACE" exec -it "$POD" -- "$COMMAND"
}

function iterm2_print_user_vars() {
  iterm2_set_user_var currentDir echo ${PWD:t}
}

#dev-tools
alias b='bundle exec'
alias br='bundle exec rspec'

alias lt_reset='PORTAL=lt bundle exec rake db:drop db:create db:schema:load db:seed'
alias lt_console='PORTAL=lt script/console'
alias lt_server='PORTAL=lt bundle exec rails s'
alias lt_migrate='PORTAL=lt bundle exec rake db:migrate'
alias lt_images='PORTAL=lt script/rails s thin --port=3010'
alias lt_ts_rebuild='PORTAL=lt bundle exec rake ts:rebuild'
alias lt_tools='PORTAL=lt dev-tools start'
alias lt_update='PORTAL=lt dev-tools update'
alias lt_lang_files='PORTAL=lt bundle exec rake i18n:generate_all_lang_files'

alias prod_console='kube-sh --context prod3 --namespace core --pod_matcher core-int-uni --command script/prod_console'
alias sandbox_console='kube-sh --context sandbox2 --namespace core --pod_matcher core-int --command script/prod_console'
#other aliases

alias tree="find . -print | sed -e 's;[^/]*/;|----;g;s;____|; |;g'"
alias e="eza --icons"
alias gitconfig="code ~/.gitconfig"
alias zshconfig="code ~/.zshrc"
alias nvimconfig="nvim ~/config/nvim"
alias ohmyzsh="code ~/.oh-my-zsh"
alias gitdf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export GOPATH="$HOME/go"
export GOPRIVATE="github.com/vinted"
export GONOSUMDB="github.com/vinted"
export GOPROXY="https://artefact-storage.svc.vinted.com/repository/go-proxy-repos-group/"
export GONOPROXY=none;
export PATH=$PATH:$HOME/go/bin
export DISABLE_SPRING=1

eval "$(direnv hook zsh)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/simas.maziliauskas/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
eval "$(mise activate)"
export PATH="$HOME/.local/bin:$PATH"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -s /Users/simas.maziliauskas/.autojump/etc/profile.d/autojump.sh ]] && source /Users/simas.maziliauskas/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
