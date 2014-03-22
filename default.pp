


user { 'tfb':
  ensure => 'present',
  groups => ['sudo'],
  shell => '/bin/bash',
  home => '/home/tfb',
  managehome => true,
  password => 'password'
}


$env_configs = '
export TFB_SERVER_HOST="localhost"
export TFB_CLIENT_HOST="localhost"
export TFB_CLIENT_USER="tfb"
export TFB_CLIENT_IDENTITY_FILE="~/.ssh/id_rsa"
export TFB_DATABASE_HOST="localhost"
export TFB_DATABASE_USER="tfb"
export TFB_DATABASE_IDENTITY_FILE="~/.ssh/id_rsa"
'


# Not sure this will work - they may prefer this is used for actual
# lines rather than full 
file_line { 'add_env':
  ensure   => 'present',
  path     => '/home/tfb/.bashrc',
  line     => $env_configs
}

file_line { 'no_passwd':
  file => '/etc/passwd',
  line => '%sudo ALL=(ALL:ALL) NOPASSWD: ALL'
}


# A work in progress to ensure that an ubuntu box is capable of
# building.  Not sure if it's entirely a good idea - it seems like you
# might be able to do this without any usage of apt (and if you do in
# fact use it, I think there is better built in handling of it for
# puppet). While in general there are some annoying interplatform
# difficulties, not sure indulging in one platforms package manager is
# probably better)
class ubuntu_config {
    exec { 'apt-get update':
      command => '/usr/bin/apt-get update'
    }
    package { 'python-software-properties':
      ensure  => installed,
      require => Exec['apt-get update']
    }
    package { 'software-properties-common':
      ensure   => installed,
      require  => Exec['apt-get update']
    }

    # While I support the idea behind this, I don't think it is
    # functional as states. You want a set of commands to ensure that
    # you are able to manipulate
    package { 'add repositories':
      command => [
                  

                 ],
      require => [Exec['apt-get update'], 
                  Package['python-software-properties'],
                  Package['software-properties-common']]
    }




    
}
#include ubuntu_config




