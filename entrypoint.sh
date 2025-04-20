#!/bin/bash

TZ=${TZ:-UTC}
export TZ

cd /home/container || exit 1

[ ! -f server.properties ] && cat > server.properties << EOF
server-ip=0.0.0.0
server-port=${SERVER_PORT}
query.port=${SERVER_PORT}
EOF

export MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

eval ${MODIFIED_STARTUP}