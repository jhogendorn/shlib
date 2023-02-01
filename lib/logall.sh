# vim: ft=sh
# Log all script output to a file {{{

YEARMONTH=$(date +%Y%m)

logfile=$SCRIPTPATH/$YEARMONTH.log
exec > >( sed -e "s/\r/\n/g" | gawk '{ print strftime("[%Y-%m-%d %H:%M:%S]: "), $0; fflush(); }' >> $logfile ) 2>&1

# }}}
