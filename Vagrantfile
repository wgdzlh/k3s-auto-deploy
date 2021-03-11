# -*- mode: ruby -*-
# vi: set ft=ruby :

NODES_NUM = 3
IP_BASE = "172.16.0."

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox"
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = ">=20210309.0.0"
  config.vm.box_check_update = false

  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/me.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /tmp/me.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

  (1..NODES_NUM).each do |i|
    config.vm.define "k8s-node-#{i + 9}" do |node|

      hostname = "k8s-node-#{i + 9}"
      if hostname == "k8s-node-10"
        cpus = 2
        memory = 2048
      else
        cpus = 1
        memory = 1024
      end

      node.vm.network "private_network", ip: "#{IP_BASE}#{i + 9}"
      node.vm.hostname = hostname
      node.vm.provider "virtualbox" do |v|
        v.linked_clone = true
        v.gui = false
        v.name = hostname
        v.cpus = cpus
        v.memory = memory
        v.customize [
          'modifyvm', :id,
          "--ioapic", "on",
          '--audio', 'none',
        ]

        # Create a block device for Longhorn on the worker nodes
        if hostname != "k8s-node-10"
          disk = "./" + hostname + "-block.vdi"
          unless File.exist?(disk)
            v.customize [
              "createhd",
              "--filename", disk,
              "--variant", "Fixed",
              "--size", 1024 * 5
            ]
          end
          v.customize [
            "storageattach", :id,
            "--storagectl", "SCSI",
            "--port", 2,
            "--device", 0,
            "--type", "hdd",
            "--medium", disk
          ]
        end
      end
    end
  end

end
