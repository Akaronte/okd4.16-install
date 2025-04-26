wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/41.20250331.3.0/x86_64/fedora-coreos-41.20250331.3.0-live.x86_64.iso

wge https://github.com/okd-project/okd/releases/download/4.16.0-okd-scos.1/openshift-install-linux-4.16.0-okd-scos.1.tar.gz

wget https://github.com/okd-project/okd/releases/download/4.16.0-okd-scos.1/openshift-client-linux-amd64-rhel8-4.16.0-okd-scos.1.tar.gz

tar -xzvf openshift-client-linux-amd64-rhel8-4.16.0-okd-scos.1.tar.gz
tar -xzvf openshift-install-linux-4.16.0-okd-scos.1.tar.gz


mv oc kubectl openshift-install /usr/local/bin/
