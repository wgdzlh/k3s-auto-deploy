kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl create -f dashboard.admin-user.yml -f dashboard.admin-user-role.yml
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token
echo http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
kubectl proxy

