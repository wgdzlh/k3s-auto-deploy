vagrant halt

for value in k8s-node-10 k8s-node-11 k8s-node-12; do
    VBoxManage modifyvm $value --audio none --macaddress1 auto --nic1 natnetwork --nat-network1 "vnet1"
    VBoxManage startvm $value --type headless
done
