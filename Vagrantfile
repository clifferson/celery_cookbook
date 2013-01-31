# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant::Config.run do |config|

  config.vm.host_name = "celery-berkshelf"
  #config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
  #config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"
  config.vm.box = "base"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  #config.vm.share_folder "celery-tasks", "/tmp/celery-tasks", "/path/to/celery/tasks/repo"

  config.vm.customize [ 
    "modifyvm", :id, 
    "--memory", "4098", 
    "--cpus", "2", 
    "--chipset", "ich9",
    "--vram", "10"
  ]


  config.vm.network :hostonly, "33.33.33.10"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }

    chef.run_list = [
      "recipe[celery::default]",
      "recipe[celery::worker]"
    ]
  end
end
