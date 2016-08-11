#!/bin/bash

##
#  File:
#    ngxsite
#  Description:
#    Provides a basic script to automate enabling, disabling, adding and
#    removing websites found in the default configuration directories:
#      /etc/nginx/sites-available and /etc/nginx/sites-enabled
#    For easy access to this script, copy it into the directory:
#      /usr/local/sbin
#    Run this script without any arguments or with 'h' or 'help' to see a
#    basic help dialog displaying all options.
#    
#    Made by PeterCP. Based on the original made by Michael Lustfield.
##

# Copyright (C) 2010 Michael Lustfield <mtecknology@ubuntu.com>

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

##
# Default Settings
##

NGINX_CONF_FILE="$(awk -F= -v RS=' ' '/conf-path/ {print $2}' <<< $(nginx -V 2>&1))"
NGINX_CONF_DIR="${NGINX_CONF_FILE%/*}"
NGINX_SITES_AVAILABLE="$NGINX_CONF_DIR/sites-available"
NGINX_SITES_ENABLED="$NGINX_CONF_DIR/sites-enabled"
SELECTED_SITE="$2"

##
# Script Functions
##

ngx_enable_site() {
    [[ ! "$SELECTED_SITE" ]] &&
        ngx_select_site "not_enabled"

    [[ ! -e "$NGINX_SITES_AVAILABLE/$SELECTED_SITE" ]] &&
        ngx_error "Site does not appear to exist."
    [[ -e "$NGINX_SITES_ENABLED/$SELECTED_SITE" ]] &&
        ngx_error "Site appears to be enabled already."

    ln -sf "$NGINX_SITES_AVAILABLE/$SELECTED_SITE" "$NGINX_SITES_ENABLED/$SELECTED_SITE"
    echo "Site '$SELECTED_SITE' enabled."
    ngx_reload
}

ngx_disable_site() {
    [[ ! "$SELECTED_SITE" ]] &&
        ngx_select_site "is_enabled"

    [[ ! -e "$NGINX_SITES_ENABLED/$SELECTED_SITE" && ! -L "$NGINX_SITES_ENABLED/$SELECTED_SITE" ]] &&
        ngx_error "Site does not appear to be enabled."
    if [[ ! -e "$NGINX_SITES_AVAILABLE/$SELECTED_SITE" ]]; then
        read -p "Site does not appear to be available. Remove anyways? (Y/n) " remove
        if [[ "$remove" != "n" && "$remove" != "N" ]]; then
            rm -f "$NGINX_SITES_ENABLED/$SELECTED_SITE"
            echo "Site '$SELECTED_SITE' was disabled."
            ngx_reload
        else
            echo "Site '$SELECTED_SITE' was not disabled."
        fi
    else
        rm -f "$NGINX_SITES_ENABLED/$SELECTED_SITE"
        echo "Site '$SELECTED_SITE' was disabled."
        ngx_reload
    fi
}

ngx_add_site() {
    [[ ! "$SELECTED_SITE" ]] &&
        ngx_error "Specify a site config file to add."
    [[ ! -e "$SELECTED_SITE" ]] &&
        ngx_error "File does not exist."

    SITEFILE=$(realpath $SELECTED_SITE)
    BASENAME=$(basename $SELECTED_SITE)

    [[ -e "$NGINX_SITES_AVAILABLE/$BASENAME" ]] &&
        ngx_error "A site with that name already exists."

    read -p "Should the file be symbolically linked (If not, it will be hard copied)? (Y/n) " copy

    read -p "How should the site be named? [$BASENAME] " GIVEN_NAME
    [[ $GIVEN_NAME != "" ]] &&
        BASENAME=$GIVEN_NAME

    if [[ "$copy" != "n" && "$copy" != "N" ]]; then
        ln -sf "$SITEFILE" "$NGINX_SITES_AVAILABLE/$BASENAME"
        echo "Site '$BASENAME' added successfully (Using symbolic link)."
    else
        cp "$SITEFILE" "$NGINX_SITES_AVAILABLE/$BASENAME"
        echo "Site '$BASENAME' added successfully (Using hard copy)."
    fi
}

ngx_remove_site() {
    [[ ! "$SELECTED_SITE" ]] &&
        ngx_select_site "not_enabled"

    [[ ! -e "$NGINX_SITES_AVAILABLE/$SELECTED_SITE" && ! -L "$NGINX_SITES_AVAILABLE/$SELECTED_SITE" ]] &&
        ngx_error "Site does not appear to exist."
    [[ -e "$NGINX_SITES_ENABLED/$SELECTED_SITE" || -L "$NGINX_SITES_ENABLED/$SELECTED_SITE" ]] &&
        ngx_error "Site appears to be enabled. It must first be disabled."

    rm "$NGINX_SITES_AVAILABLE/$SELECTED_SITE"
    echo "Site '$SELECTED_SITE' removed successfully."
}

ngx_list_site() {
    echo "Available sites"
    ngx_sites "available"
    echo "Enabled Sites"
    ngx_sites "enabled"
}

##
# Helper Functions
##

# realpath() {
#     OURPWD=$PWD
#     cd "$(dirname "$1")"
#     LINK=$(readlink "$(basename "$1")")
#     while [ "$LINK" ]; do
#         cd "$(dirname "$LINK")"
#         LINK=$(readlink "$(basename "$1")")
#     done
#     REALPATH="$PWD/$(basename "$1")"
#     cd "$OURPWD"
#     echo "$REALPATH"
# }

ngx_select_site() {
    sites_avail=($NGINX_SITES_AVAILABLE/*)
    sa="${sites_avail[@]##*/}"
    sites_en=($NGINX_SITES_ENABLED/*)
    se="${sites_en[@]##*/}"

    case "$1" in
        not_enabled) sites=$(comm -13 <(printf "%s\n" $se) <(printf "%s\n" $sa));;
        is_enabled) sites=$(comm -12 <(printf "%s\n" $se) <(printf "%s\n" $sa));;
    esac

    ngx_prompt "$sites"
}

ngx_prompt() {
    sites=($1)
    i=0

    echo "SELECT A WEBSITE:"
    for site in ${sites[@]}; do
        echo -e "$i:\t${sites[$i]}"
        ((i++))
    done

    read -p "Enter number for website: " i
    SELECTED_SITE="${sites[$i]}"
}

ngx_sites() {
    case "$1" in
        available) dir="$NGINX_SITES_AVAILABLE";;
        enabled) dir="$NGINX_SITES_ENABLED";;
    esac

    for file in $dir/*; do
        echo -e "\t${file#*$dir/}"
    done
}

ngx_reload() {
    read -p "Would you like to reload the Nginx configuration now? (Y/n) " reload
    [[ "$reload" != "n" && "$reload" != "N" ]] && sudo nginx -s reload
}

ngx_error() {
    echo -e "${0##*/}: ERROR: $1"
    [[ "$2" ]] && ngx_help
    exit 1
}

ngx_help() {
    echo "Usage: ${0##*/} [options]"
    echo "Options:"
    echo -e "\t[e|enable]  <site>   Enable site"
    echo -e "\t[d|disable] <site>   Disable site"
    echo -e "\t[a|add]     <site>   Add site"
    echo -e "\t[r|remove]  <site>   Remove site"
    echo -e "\t[l|list]             List sites"
    echo -e "\t[h|help]             Display help"
    echo -e "\n\tIf <site> is left out a selection of options will be presented."
    echo -e "\tIt is assumed you are using the default sites-enabled and"
    echo -e "\tsites-disabled located at $NGINX_CONF_DIR."
}

##
# Core Piece
##

case "$1" in
    e|enable)    ngx_enable_site;;
    d|disable)   ngx_disable_site;;
    a|add)       ngx_add_site;;
    r|remove)    ngx_remove_site;;
    l|list)      ngx_list_site;;
    h|help)      ngx_help;;
    *)      ngx_error "No Options Selected" 1; ngx_help;;
esac
