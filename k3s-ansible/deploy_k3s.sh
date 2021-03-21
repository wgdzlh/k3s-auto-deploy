# ansible k3s_cluster --become -a "timedatectl set-timezone Asia/Shanghai"
# ansible k3s_cluster --become -m apt -a "name=snapd state=absent purge=yes"
# ansible k3s_cluster --become -m apt -a "autoremove=yes purge=yes"

ansible-playbook site.yml
scp vagrant@172.16.1.10:~/.kube/config ~/.kube/config

# kubectl get nodes --all-namespaces -o wide
# kubectl get deploy --all-namespaces -o wide
# kubectl get pods --all-namespaces -o wide
# kubectl get svc --all-namespaces -o wide
