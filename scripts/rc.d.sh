#!/bin/sh

. /etc/rc.subr

name="sabnzbdvpn"
start_cmd="${name}_start"
stop_cmd="${name}_stop"

sabnzbdvpn_start()
{
    /FreeNAS-SABnzbd-OpenVPN/run.sh
}

sabnzbdvpn_stop()
{
    /FreeNAS-SABnzbd-OpenVPN/stop.sh
}


load_rc_config $name
run_rc_command "$1"
