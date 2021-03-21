vagrant halt

HOST_NETWORK="vboxnet1"
# IP_BASE="172.16.1"
# NAT_BASE="10.3.7"
# BRG_NETWORK="bridge100"

# VBoxManage natnetwork add --netname ${NAT_NETWORK} --network ${NAT_BASE}.0/24 --dhcp off --ipv6 off
# VBoxManage natnetwork modify --netname ${NAT_NETWORK} --port-forward-4 "k3s_master:tcp:[0.0.0.0]:6443:[${NAT_BASE}.10]:6443"

CLUSTER="k8s-node-10 k8s-node-11 k8s-node-12"

for value in ${CLUSTER}; do
    VBoxManage modifyvm ${value} --audio none --macaddress1 auto --nic1 hostonly --hostonlyadapter1 ${HOST_NETWORK}
    VBoxManage startvm ${value} --type headless
done
