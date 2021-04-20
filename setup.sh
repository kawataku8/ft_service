#/bin/bash

sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535

sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
sudo kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
sudo kubectl apply -f metalLB.yaml 

# sudo kubectl apply -f ./nginx/nginx.yaml
# sudo kubectl apply -f ./ftps/ftps_deploy.yaml
sudo kubectl apply -f ./mysql/mysql.yaml
sudo kubectl apply -f ./debug_pod/debugpod.yaml
# sudo kubectl apply -f ./wordpress/wp.yaml
sudo kubectl apply -f ./phpmyadmin/phpadmin.yaml
