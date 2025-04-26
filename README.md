apt install bind9 bind9utils bind9-doc haproxy git -y
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y

wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/41.20250331.3.0/x86_64/fedora-coreos-41.20250331.3.0-live.x86_64.iso

wge https://github.com/okd-project/okd/releases/download/4.16.0-okd-scos.1/openshift-install-linux-4.16.0-okd-scos.1.tar.gz

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