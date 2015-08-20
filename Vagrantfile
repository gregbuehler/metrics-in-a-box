
$script = <<SCRIPT
  # install environment and library dependencies
  sudo apt-get -y update
  sudo apt-get -y install \
    git-core \
    curl \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    python-software-properties \
    libffi-dev \
    libfontconfig \
    adduser \
    ruby-dev \
    nodejs

  # install and start influx
  wget http://influxdb.s3.amazonaws.com/influxdb_0.9.2_amd64.deb
  sudo dpkg -i influxdb_0.9.2_amd64.deb
  sudo /etc/init.d/influxdb start

  # install and start grafana
  wget https://grafanarel.s3.amazonaws.com/builds/grafana_2.1.1_amd64.deb
  sudo dpkg -i grafana_2.1.1_amd64.deb
  sudo /etc/init.d/grafana-server start

  # add database and users to influx
  /opt/influxdb/influx -execute "CREATE DATABASE 'data'"
  /opt/influxdb/influx -execute "CREATE USER foo WITH PASSWORD 'bar'"
  /opt/influxdb/influx -execute "CREATE USER admin WITH PASSWORD 'admin' WITH ALL PRIVILEGES"

  # setup daemon service
  sudo gem install bundler foreman
  pushd /vagrant && bundle install && foreman start
SCRIPT

Vagrant.configure(2) do |config|

  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = "ubuntu/trusty64"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Forward the server default port to the host
  config.vm.network :forwarded_port, guest: 8083, host: 8083
  config.vm.network :forwarded_port, guest: 8084, host: 8084
  config.vm.network :forwarded_port, guest: 8086, host: 8086
  config.vm.network :forwarded_port, guest: 8088, host: 8088
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # provision the vm
  config.vm.provision "shell", inline: $script
end
