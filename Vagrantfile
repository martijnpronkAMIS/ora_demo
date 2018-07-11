require 'yaml'

VAGRANTFILE_API_VERSION = '2'.freeze

# Read YAML file with box details
servers = YAML.load_file('servers.yaml')


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  servers.each do |name, server|
    config.vm.define name do |srv|
      srv.vm.box = ENV['BASE_IMAGE'] ? (ENV['BASE_IMAGE']).to_s : server['box']
      srv.vm.hostname = "#{name}.example.com"
      srv.vm.network 'private_network', ip: server['public_ip']
      srv.vm.network 'private_network', ip: server['private_ip'], virtualbox__intnet: true
      srv.vm.synced_folder '.', '/vagrant', type: :virtualbox
      #
      # Fix hostnames because Vagrant mixes it up.
      #
      srv.vm.provision :shell, inline: <<-EOD
cat > /etc/hosts<< "EOF"
127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4
#{server['public_ip']} #{name}.example.com #{name}
EOF
EOD
    srv.vm.provision :shell, inline: 'ln -f -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime'
    srv.vm.provision :shell, inline: 'rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm'
	srv.vm.provision :shell, inline: 'yum -y install puppet-agent'
	
    srv.vm.provision :shell, path: 'vm-scripts/setup_puppet.sh'
    srv.vm.provision :shell, inline: 'puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp  --verbose --trace'

      config.vm.provider :virtualbox do |vb|
        # vb.gui = true
        vb.cpus = server['cpucount'] || 1
        vb.memory = server['ram'] || 4096
        vb.customize ['modifyvm', :id, '--ioapic', 'on']
        vb.customize ['modifyvm', :id, '--name', name]
        if server['virtualboxorafix'] == 'enable'
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/Leaf', '0x4']
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/SubLeaf', '0x4']
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/eax', '0']
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/ebx', '0']
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/ecx', '0']
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/edx', '0']
          vb.customize ['setextradata', :id, 'VBoxInternal/CPUM/HostCPUID/Cache/SubLeafMask', '0xffffffff']
        end
      end
    end
  end
end
