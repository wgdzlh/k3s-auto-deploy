# Build a portable Kubernetes cluster using k3s via Ansible - on local VMs and Raspberry Pies

> Author: <https://github.com/wgdzlh>


## Goal

The project is for enthusiasts who do not want try k8s on minikube or k3d, but a cluster as "real" as possible. The goal is to setup a bunch of local VMs on our main laptop, and connect in Raspberry Pies or other mini PCs available, to build up a portable environment for developing and testing.


## Requirements on your local machine

- Macos(tested) / Linux(should working) / Windows WSL(if support tools listed down, no guarantee working)
- memory \>= 16GB, for VMs setup
- Virtual Box
- Vagrant
- Ansible


## Usage

1. set up a virtual router on our PC, so we don't have to carry a real router around, and set up a local virtual subnet that isolated from ourter ones:

    ```bash
    cd vrouter
    vi Vagrantfile   # to change network config, refer to the content for detail
    vagrant up --no-provision --no-tty
    vagrant provision
    ```

2. after our vrouter up and run, go ahead and config it like a real OpenWrt router. You should better add some static DHCP leases for devices to connect in.

3. set up VMs cluster:

    ```bash
    cd ..  # project root directory
    vi Vagrantfile  # to change network config, timezone, VM nodes number
    vagrant up
    sh after_setup_vms.sh
    ```

3. set up k3s on VMs cluster via Ansible:

    ```bash
    cd k3s-ansible
    vi ./inventory/my-cluster/hosts.ini  # refer to k3s-ansible/README.md for detail
    sh deploy_k3s.sh
    ```

4. (This step is only for adding more gears to the cluster) After VMs cluster up and running, connect your Raspberry Pies to the laptop via ordinary ethernet cable (and using a network switch if you got more than one), get IP addresses from the vrouter management page, add them in you ansible inventory `hosts.ini` file (under `node2` section), and fire playbook:

    ```bash
    ansible-playbook add_node.yml
    ```

5. All done. You are good to go.


## Special Thanks

- [Ansible](https://www.ansible.com/)
- [K3s](https://k3s.io/)
- [OpenWrt](https://openwrt.org/)
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)
- [onedr0p/k3s-homeops-ansible](https://github.com/onedr0p/k3s-homeops-ansible)
- [vladimir-babichev/vagrant-openwrt-box](https://github.com/vladimir-babichev/vagrant-openwrt-box)
