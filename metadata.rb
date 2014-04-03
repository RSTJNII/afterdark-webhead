name             'afterdark-webhead'
maintainer       'Thomas Noonan II'
maintainer_email 'thomas.noonan@rackspace.com'
license          'All rights reserved'
description      'Installs/Configures afterdark-webhead'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

depends "rackspace_nginx", "~> 3.1"
depends "rackspace_iptables", "~> 1.2"
