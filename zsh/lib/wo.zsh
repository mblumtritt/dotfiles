wo() { curl http://find/clients.txt 2>/dev/null | awk '{print $1, "\t" $3}' | grep -i "$@" | expand -t30}
