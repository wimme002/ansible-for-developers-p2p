#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
did_apt_get_update=
sh_c='sh -c'

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

apt_get_update() {
	if [ -z "$did_apt_get_update" ]; then
		( set -x; $sh_c 'sleep 3; apt-get update' )
		( set -x; $sh_c 'sleep 3; apt-get upgrade -y' )
	    did_apt_get_update=1
    fi
}

#if ! command_exists python-dev; then
    apt_get_update
    echo >&2 'Installing python'
    ( set -x; $sh_c 'sleep 3; apt-get install -y -q python-dev' )
    ( set -x; $sh_c 'sleep 3; apt-get install -y -q python-pip' )
    ( set -x; $sh_c 'sleep 3; apt-get install -y -q python-apt' )
    ( set -x; $sh_c 'sleep 3; easy_install pip' )
#fi

if ! command_exists ansible-playbook; then
    echo >&2 'Installing ansible'
    ( set -x; $sh_c 'sleep 3; pip install ansible' )
fi
