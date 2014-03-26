


user { 'tfb':
  ensure => 'present',
  groups => ['sudo'],
  shell => '/bin/bash',
  home => '/home/tfb',
  managehome => true,
  password => 'password'
}

ssh_keygen { 'tfb': }

$env_configs = '
export TFB_SERVER_HOST="localhost"
export TFB_CLIENT_HOST="localhost"
export TFB_CLIENT_USER="tfb"
export TFB_CLIENT_IDENTITY_FILE="~/.ssh/id_rsa"
export TFB_DATABASE_HOST="localhost"
export TFB_DATABASE_USER="tfb"
export TFB_DATABASE_IDENTITY_FILE="~/.ssh/id_rsa"
'

#A work in progrss to automatically set up an ubuntu box
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
}
include ubuntu_config



# Not sure this will work - they may prefer this is used for actual
# lines rather than full 
file_line { 'add_env':
  ensure   => 'present',
  path     => '/home/tfb/.bashrc',
  line     => $env_configs
}

file_line { 'no_passwd':
  path => '/etc/sudoers',
  line => '%sudo ALL=(ALL:ALL) NOPASSWD: ALL'
}


# apt::ppa { 'ppa:ubuntu-toochain-r/test': }


# gets basic dependencies
# package { 'build-essential': }
# package { 'libpcre3': }
# package { 'libpcre3-dev': }
# package { 'libpcrecpp0': }
# package { 'libssl-dev': }
# package { 'zlib1g-dev': }
# package { 'python-software-properties': }
# package { 'unzip': }
# package { 'git-core': }
# package { 'libcurl4-openssl-dev': }
# package { 'libbz2-dev': }
# package { 'libmysqlclient-dev': }
# package { 'mongodb-clients': }
# package { 'libreadline6-dev': }
# package { 'libyaml-dev': }
# package { 'libsqlite3-dev': }
# package { 'sqlite3': }
# package { 'libxml2-dev': }
# package { 'libxslt-dev': }
# package { 'libgdbm-dev': }
# package { 'ncurses-dev': }
# package { 'automake': }
# package { 'libffi-dev': }
# package { 'htop': }
# package { 'libtool': }
# package { 'bison': }
# package { 'libevent-dev': }
# package { 'libgstreamer-plugins-base0.10-0': }
# package { 'libgstreamer0.10-0': }
# package { 'liborc-0.4-0': }
# package { 'libwxbase2.8-0': }
# package { 'libwxgtk2.8-0': }
# package { 'libgnutls-dev': }
# package { 'libjson0-dev': }
# package { 'libmcrypt-dev': }
# package { 'libicu-dev': }
# package { 'cmake': }
# package { 'gettext': }
# package { 'curl': }
# package { 'libpq-dev': }
# package { 'mercurial': }
# package { 'mlton': }


