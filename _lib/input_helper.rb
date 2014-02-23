
module InputHelper

def self.ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def self.ask_arch
  case ask("architecure?(x86_64[6], arm[a], i386[3], arm64[r])",['a','3','6','r'])
  when '6'
    'x86_64'
  when '3'
    'i686'
  when 'a'
    'arm'
  when 'r'
    'arm64'
  else
    'x86_64'
  end
end

def self.ask_plugin_type
  case ask("plugin type?(_Provider, p_Rovisioner, _Command, _Sync)", ['p','r','c','s'])
  when 'p'
    type = "provider"
  when 'r'
    type = "provisioner"
  when 'c'
    type = "command"
  when 's'
    type = "sync_folder"
  else
    type = "unknown"
  end
  type
end

def self.ask_single_provider
  case ask("Provider?(_Virtualbox, v_Mware, _Lxc, _Kvm, libv_Irt)", ['v','m','l','k','i'])
  when 'v'
    provider = "VirtualBox"
  when 'm'
    provider = "VMware"
  when 'l'
    provider = "Vagrant-LXC"
  when 'k'
    provider = "Vagrant-KVM"
  when 'i'
    provider = "Vagrant-libvirt"
  else
    provider = "unknown"
  end
  provider
end

def self.get_stdin(message)
  print message
  STDIN.gets.chomp
end

end
