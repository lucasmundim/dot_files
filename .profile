# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# MacPorts Installer addition on 2010-06-16_at_23:23:45: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=/Developer/android-sdk-mac_86/tools:$PATH

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export USER_BASH_COMPLETION_DIR=~/.bash_completion.d

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export GIT_EDITOR="mate -w"
export PATH=/usr/local/mysql/bin/:$PATH
export PATH=/Applications/Adobe\ Flash\ Builder\ 4/sdks/4.1.0/bin:$PATH
export ANT_OPTS="-XX:MaxPermSize=128M -Xms128M -Xmx512M"
export FLEX_HOME=/Applications/Adobe\ Flash\ Builder\ 4/sdks/4.1.0
