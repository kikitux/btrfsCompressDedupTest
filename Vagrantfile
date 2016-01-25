Vagrant.configure("2") do |config|
  # ZLIB -- slower, higher compression ratio (uses zlib level 3 setting, you can see the zlib level difference between 1 and 6 in zlib sources).
  # LZO -- faster compression and decompression than zlib, worse compression ratio, designed to be fast
  num_disk = 5 # source bare dedup compression1 compression2  
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_desktop"
  config.vm.define vm_name = "butter" do |btrfs|
    btrfs.vm.hostname = vm_name
    btrfs.vm.box = "ubuntu/trusty64"
    btrfs.vm.network :forwarded_port, guest: 8080, host: 8080
    btrfs.vm.provider "virtualbox" do |vb|
      vb.customize ['modifyvm', :id, '--memory', '2048']
      vb.customize ['modifyvm', :id, '--cpus', '2']
      vb.name=vm_name
      #create disk for demo
      (1..num_disk).each do |i|
        disk="#{File.dirname(__FILE__)}/disk#{i}.vdi"
        vb.customize ['createhd', '--filename', disk, '--size', '20480'] unless File.exists?(disk)
        vb.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 1+i, '--device', '0', '--type', 'hdd', '--medium', disk]
      end  
    end
    #polipo proxy
    btrfs.vm.synced_folder "polipo", "/var/cache/polipo" , :mount_options => ["uid=13,gid=13"], create: true
    btrfs.vm.provision :shell, :path => "scripts/proxy.sh", :run => "always"
    # provision the box
    btrfs.vm.provision :shell, :path => "scripts/provision.sh"
    btrfs.vm.provision :shell, :path => "scripts/hdd.sh"
    btrfs.vm.provision :shell, :path => "scripts/rsync.sh"
  end
end
