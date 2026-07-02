export EDITOR=nvim
export VISUAL=nvim

export PATH="~/.npm-packages/bin:$PATH"

export NODE_PATH="~/.npm-packages/lib/node_modules"
export PS1="\e[0;30m[\u@\h \W]\$ \e[m"

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
