vagrant halt

NAT_NETWORK="vnet1"

VBoxManage natnetwork add --netname ${NAT_NETWORK} --network 10.3.7.0/24 --dhcp on --ipv6 off

for value in k8s-node-10 k8s-node-11 k8s-node-12; do
    VBoxManage modifyvm ${value} --audio none --macaddress1 auto --nic1 natnetwork --nat-network1 ${NAT_NETWORK}
    VBoxManage startvm ${value} --type headless
done
