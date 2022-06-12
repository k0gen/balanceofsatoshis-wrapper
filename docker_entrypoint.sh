#!/bin/bash

set -a

useradd -m -s /bin/bash bos
echo bos:embassy | chpasswd
usermod -a -G root bos
mkdir -p /home/bos/.bos/embassy
chmod -R a+x /home/bos/.bos
mv /credentials.json /home/bos/.bos/embassy/credentials.json
chmod a+x /home/bos/.bos/embassy/credentials.json
chmod 640 /mnt/lnd/admin.macaroon
cat >> /home/bos/.bashrc <<"LOL"
export BOS_DEFAULT_SAVED_NODE=embassy
if [[ -z "$STY" ]]; then
   screen -xRRU bos
fi
LOL
wetty -b / --title Balance of Satoshi for Embassy
