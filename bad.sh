# What's the traffic to my app?
zgrep -h "/myapp" /var/log/archive/apache.* | gawk --re-interval -v ipre='[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}' 'match($0,ipre,ip) && !(ip[0] in ips) {ips[ip[0]]; print}' | sort -k1M -k2n | uniq -cw6 | awk '{print $2" "$3": "$1}'

# Convert a list of IPs for an IP->Email map.
cat outdated.tsv|gawk 'BEGIN {f="t";q="select i.ip, r.email from r join i on r.id = i.id where i.active=QtQ and i.ip in ("}/ipaddr=/{match($0,/ipaddr=([0-9.]+)/,ip);if(f=="t"){f="f"}else{q=q","}q=q"Q"ip[1]"Q"}END{q=q");";print q}'|tr Q \'|psql -h dbhost db|head -n-2|tail -n+3|sed 's/|/,/g'|tee emails.csv

# Handle that misbehaving co-worker.
git(){
	if [ "$1" = "add" ]; then
		find $(git rev-parse --show-toplevel) -name \*.py -exec sed -i.bak 's/\t/    /g' {} +;
	fi
	/usr/bin/git $@
}
