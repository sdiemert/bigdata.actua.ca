cd ~/bigdata.actua.ca/
HOSTNAME=bigdata.actua.ca nodejs app.js > ~/logs/out.log 2> ~/logs/error.log &
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3000 
