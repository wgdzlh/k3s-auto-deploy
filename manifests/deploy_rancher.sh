kubectl create namespace cattle-system
kubectl create namespace cert-manager
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.crds.yaml
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.0.4
#sleep 10
#helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rancher.lab.gd --set replicas=1 --version 2.5.6
#kubectl -n cattle-system rollout status deploy/rancher

