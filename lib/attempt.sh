
attempt () {
  COUNT=$1; shift
  PAUSE=$1; shift
  CALL=$@;

  n=0
  until [ "$n" -ge $COUNT ]
  do
     $CALL && break
     n=$((n+1)) 
     sleep $PAUSE
  done
}
