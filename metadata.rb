name 'kafka-cluster'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures Apache Kafka.'
long_description 'Application cookbook which installs and configures Apache Kafka.'
version '1.0.1'

supports 'ubuntu', '>= 12.04'
supports 'centos', '>= 6.6'
supports 'redhat', '>= 6.6'

suggests 'zookeeper-cluster'

depends 'libartifact', '~> 1.2'
depends 'poise', '~> 2.0'
depends 'poise-service'
depends 'sysctl'
depends 'ulimit'
