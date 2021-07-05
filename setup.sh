#/bin/bash

sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535

sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
sudo kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
sudo kubectl apply -f ./srcs/metallb/metalLB.yaml

# docker image build
docker build -t tk_nginx_img ./srcs/nginx
docker build -t tk_grafana_img ./srcs/Grafana
docker build -t tk_influx_img ./srcs/influxDB
docker build -t tk_phpadmin_img ./srcs/phpmyadmin
docker build -t tk_wp_img ./srcs/wordpress
docker build -t tk_mysql_img ./srcs/mysql
docker build -t tk_ftps_img ./srcs/ftps

# apply a configuration to a resource
sudo kubectl apply -f ./srcs/nginx/nginx.yaml
sudo kubectl apply -f ./srcs/ftps/ftps_deploy.yaml
sudo kubectl apply -f ./srcs/mysql/mysql.yaml
sudo kubectl apply -f ./srcs/phpmyadmin/phpadmin.yaml
sudo kubectl apply -f ./srcs/influxDB/influx.yaml
sudo kubectl apply -f ./srcs/Grafana/grafana.yaml
sudo kubectl apply -f ./srcs/wordpress/wp.yaml

# sudo minikube dashboard