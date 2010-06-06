#!/usr/bin/ruby
require 'socket'
require 'yaml'
require 'lib/events.rb'
require 'lib/hooks.rb'

$config = YAML.load_file('config.yml') #Read config.yml into a hash

$irc_connection = TCPSocket.open($config[:connection][:server], $config[:connection][:port])
def rawsend (line)
  puts "--> #{line}"
  $irc_connection.puts(line)
end
rawsend("NICK #{$config[:connection][:nickname]}")
rawsend("USER #{$config[:connection][:username]} * * :#{$config[:connection][:realname]}")
while ($line = $irc_connection.gets) do
  puts "<-- #{$line}"
  fireevent(:ping, {:token => $line.split[1]}) if $line.split[0] == 'PING'
  fireevent(:invite, {:channel => $line.split[3]}) if $line.split[1] == 'INVITE'
end