apt install bind9 bind9utils bind9-doc haproxy git -y
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y


wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/38.20230609.3.0/x86_64/fedora-coreos-38.20230609.3.0-live.x86_64.iso

wget https://github.com/okd-project/okd/releases/download/4.16.0-okd-scos.1/openshift-install-linux-4.16.0-okd-scos.1.tar.gz

wget https://github.com/okd-project/okd/releases/download/4.16.0-okd-scos.1/openshift-client-linux-amd64-rhel8-4.16.0-okd-scos.1.tar.gz

tar -xzvf openshift-client-linux-amd64-rhel8-4.16.0-okd-scos.1.tar.gz
tar -xzvf openshift-install-linux-4.16.0-okd-scos.1.tar.gz


mv oc kubectl openshift-install /usr/local/bin/


sudo apt install -y curl gpg gcc make pkg-config libssl-dev
sudo apt install libzstd-dev

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

git clone https://github.com/coreos/coreos-installer.git
cd coreos-installer
cargo build --release
sudo cp target/release/coreos-installer /usr/local/bin/


sudo named-checkconf
named-checkzone master1.kube2.okd.piensoluegoinstalo.com.zone /var/cache/bind/kube2.okd.piensoluegoinstalo.com.zone
named-checkzone master1.kube1.okd.piensoluegoinstalo.com.zone /var/cache/bind/kube1.okd.piensoluegoinstalo.com.zone

sudo named-checkzone 200.168.192.IN-ADDR.ARPA /var/cache/bind/200.168.192.IN-ADDR.ARPA.zone
sudo named-checkzone 100.168.192.IN-ADDR.ARPA /var/cache/bind/100.168.192.IN-ADDR.ARPA.zone


named-checkzone master1.kube1.okd.piensoluegoinstalo.com.zone /var/cache/bind/kube1.okd.piensoluegoinstalo.com.zone



dig @127.0.0.1 bootstrap.kube1.okd.piensoluegoinstalo.com



export KUBECONFIG=~/install_dir/auth/kubeconfig

oc get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc adm certificate approve



cat install_dir/auth/kubeadmin-password

oc adm policy add-cluster-role-to-user cluster-admin admin



----


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml


oc adm policy add-scc-to-group anyuid system:authenticated  -n metallb-system


oc adm policy add-scc-to-user privileged  -z speaker -n metallb-system


oc adm policy add-scc-to-user anyuid controller -n metallb-system


apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: metallb
  namespace: metallb-system


apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: defaults-ips
  namespace: metallb-system
spec:
  addresses:
  - 192.168.200.100-192.168.200.150
  autoAssign: true


cat << EOF | oc apply -f -
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: metallb
  namespace: metallb-system
EOF


cat << EOF | oc apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: defaults-ips
  namespace: metallb-system
spec:
  addresses:
  - 192.168.200.100-192.168.200.150
  autoAssign: true
  interfaces:
  - ens18
EOF


oc adm policy add-scc-to-user privileged -n metallb-system -z speaker

arping -I ens19 192.168.200.100

--------
1. Instalar el servidor NFS
En Ubuntu, el paquete equivalente a nfs-utils es nfs-kernel-server. Ejecuta:​

sudo apt update
sudo apt install nfs-kernel-server
Este paquete incluye rpcbind, necesario para el funcionamiento de NFS.​

2. Habilitar y arrancar los servicios necesarios
Activa y arranca los servicios de NFS y rpcbind:​

bash
Copiar
Editar
sudo systemctl enable --now nfs-kernel-server
sudo systemctl enable --now rpcbind
Esto garantiza que los servicios se inicien automáticamente al arrancar el sistema.​

3. Crear y configurar el directorio compartido
Crea el directorio que deseas compartir y establece los permisos adecuados:​
vigneshsubbaiah.medium.com


bash
Copiar
Editar
sudo mkdir -p /var/nfsshare
sudo chmod -R 755 /var/nfsshare
Esto permite que otros usuarios puedan leer y ejecutar archivos en ese directorio.​

4. Configurar las exportaciones NFS
Edita el archivo /etc/exports para definir qué directorios se compartirán y con qué permisos:​
pc-freak.net
+2
unixmen.com
+2
vigneshsubbaiah.medium.com
+2

bash
Copiar
Editar
sudo nano /etc/exports


bash
Copiar
Editar
/var/nfsshare 192.168.200.0/24(rw,sync,no_subtree_check)



helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm repo update

helm install nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --set nfs.server=192.168.100.199 --set nfs.path=/var/nfsshare --set storageClass.name=nfs-provisioner

oc patch storageclass nfs-provisioner -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'



---
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform


---



   oc adm policy add-scc-to-user anyuid -z nginx-ingress-serviceaccount -n nginx-ingress

   oc adm policy add-scc-to-user anyuid -z nginx-ingress -n nginx-ingress




oc adm policy add-scc-to-user anyuid -z default -n ingress-nginx
oc adm policy add-scc-to-user anyuid -z nginx-ingress -n ingress-nginx


helm install nginxingress ingress-nginx/ingress-nginx -f nginx-values.yaml



----
git clone https://github.com/nginx/kubernetes-ingress.git --branch v5.0.0
cd kubernetes-ingress


oc new-project  nginx-ingress
kubectl apply -f deployments/common/ns-and-sa.yaml
kubectl apply -f deployments/rbac/rbac.yaml
kubectl apply -f examples/shared-examples/default-server-secret/default-server-secret.yaml
kubectl apply -f deployments/common/nginx-config.yaml
kubectl apply -f deployments/common/ingress-class.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/kubernetes-ingress/v5.0.0/deploy/crds.yaml
kubectl apply -f deployments/deployment/nginx-ingress.yaml
kubectl get pods --namespace=nginx-ingress
kubectl apply -f deployments/service/loadbalancer.yaml

#fix deployment runAsUser in yaml
securityContext:
  capabilities:
    add:
      - NET_BIND_SERVICE
    drop:
      - ALL
  runAsUser: 1000770001
  runAsNonRoot: true
  allowPrivilegeEscalation: false



curl --resolve ingress-maven-app.ingress.kube2.okd.piensoluegoinstalo.com:80:192.168.200.100 http:/ingress-maven-app.ingress.kube2.okd.piensoluegoinstalo.com/hello
----



# =========================
# Upstreams
# =========================

upstream ingress280 {
    server 192.168.200.100:80;
}

upstream ingress2443 {
    server 192.168.200.100:443;
}

upstream kube280 {
    server 192.168.1.41:80;
}

upstream kube2443 {
    server 192.168.1.41:443;
}

# =========================
# HTTP for ingress subdomain
# =========================

server {
    listen 80;
    server_name *.ingress.kube2.okd.piensoluegoinstalo.com;

    location / {
        proxy_pass http://ingress280;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;

        proxy_set_header Accept-Encoding "";
        proxy_buffering off;
    }
}

# =========================
# HTTPS for ingress subdomain
# =========================

server {
    listen 443 ssl http2;
    server_name *.ingress.kube2.okd.piensoluegoinstalo.com;

    ssl_certificate /etc/letsencrypt/live/ingress.kube2.okd.piensoluegoinstalo.com/cert.pem;
    ssl_certificate_key /etc/letsencrypt/live/ingress.kube2.okd.piensoluegoinstalo.com/privkey.pem;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    location / {
        proxy_pass https://ingress2443;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_ssl_name $host;
        proxy_ssl_server_name on;
        proxy_ssl_session_reuse off;
    }
}

# =========================
# HTTP for apps subdomain
# =========================

server {
    listen 80;
    server_name *.apps.kube2.okd.piensoluegoinstalo.com;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    location / {
        proxy_pass http://kube280;

        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# =========================
# HTTPS for apps subdomain
# =========================

server {
    listen 443 ssl http2;
    server_name *.apps.kube2.okd.piensoluegoinstalo.com;

    ssl_certificate /etc/letsencrypt/live/apps.kube2.okd.piensoluegoinstalo.com/cert.pem;
    ssl_certificate_key /etc/letsencrypt/live/apps.kube2.okd.piensoluegoinstalo.com/privkey.pem;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    location / {
        proxy_pass https://kube2443;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_ssl_name $host;
        proxy_ssl_server_name on;
        proxy_ssl_session_reuse off;
    }
}
