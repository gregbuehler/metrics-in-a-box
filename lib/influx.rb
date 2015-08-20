require 'influxdb'

influxdb_config_file = File.dirname(File.expand_path(__FILE__)) + '/../config/influxdb.yml'
influxdb_config = YAML::load(File.open(influxdb_config_file))


influxdb = InfluxDB::Client.new influxdb_config['database'],
                                username: influxdb_config['username'],
                                password: influxdb_config['password'],
                                async: true
