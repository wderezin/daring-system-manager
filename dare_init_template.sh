#!/bin/sh
#
# Steps:
# 1) Rename starting with a numeric [0-9] and place into a subscriber directory
# 2) Implement the install function.  Use the LSB RC codes at the bottom.
# 3) Implement any other optional function.

. /etc/default/dare-sm


install() {
    return ${RC_NOT_IMPLEMENTED}
}
upgrade() {
    return ${RC_NOT_IMPLEMENTED}
}
# Used by dare-sm during install/upgrade
installStart() {
    return ${RC_NOT_IMPLEMENTED}
}
# Used by dare-sm during install/upgrade
installStop() {
    return ${RC_NOT_IMPLEMENTED}
}

status() {
    return 4
}
start() {
    return ${RC_NOT_IMPLEMENTED}
}
stop() {
    return ${RC_NOT_IMPLEMENTED}
}
restart() {
    if stop
    then
        start
        return $?
    else
        return $?
    fi
}

case "$1" in
    install)
        install
        RETVAL=$?
	;;
	upgrade)
	    upgrade
	    RETVAL=$?
    ;;
    install-start)
        installStart
        RETVAL=$?
	;;
    install-stop)
        installStop
        RETVAL=$?
	;;
	start)
        start
        RETVAL=$?
    ;;
    stop)
        stop
        RETVAL=$?
	;;
	restart)
        restart
        RETVAL=$?
    ;;
    status)
        status
        RETVAL=$?
	;;
    *)
        echo "$0: $1 option not implemented"
        echo "Usage: $0 {install|upgrade|start|stop|restart|status}"
        RETVAL=3
	;;
esac

exit ${RETVAL}

# LSB RC (Return Codes) for all commands but status:
# 0	 - success
# 1  - generic or unspecified error
# 2  - invalid or excess argument(s)
# 3  - unimplemented feature (e.g. "reload")
# 4  - user had insufficient privileges
# 5  - program is not installed
# 6  - program is not configured
# 7  - program is not running
# 8--199  - reserved (8--99 LSB, 100--149 distrib, 150--199 appl)
#
# Note that starting an already running service, stopping
# or restarting a not-running service as well as the restart
# with force-reload (in case signaling is not supported) are
# considered a success.
#
# LSB RC for status command:
# 0 - service up and running
# 1 - service dead, but /var/run/  pid  file exists
# 2 - service dead, but /var/lock/ lock file exists
# 3 - service not running (unused)
# 4 - service status unknown :-(
# 5--199 reserved (5--99 LSB, 100--149 distro, 150--199 appl.)