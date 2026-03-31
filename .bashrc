#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

source $HOME/bin/run_code_analysis.sh
source $HOME/bin/load_env.sh
export MY_ZIVID_SDK_BUILD_DIRECTORY=$HOME/dev/zivid-sdk/sdk/build/linux-debug-dev-clang
source $HOME/dev/zivid-sdk/sdk/developer-tools/bash/scripts.sh

PS1='[\u@\h \W]\$ '

PATH="/home/jlind/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jlind/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jlind/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jlind/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jlind/perl5"; export PERL_MM_OPT;
export PATH="$HOME/.local/bin:$PATH"
