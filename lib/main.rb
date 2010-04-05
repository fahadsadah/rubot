#!/usr/bin/ruby
require 'socket'
#TODO: Configurability
$irc_connection = TCPSocket.open('irc.cluenet.org', 6667) #CONFIG: Connection details
def rawsend (line)
  puts "--> #{line}"
  $irc_connection.puts(line)
end
rawsend('NICK Rubot') #CONFIG: Nick
rawsend('USER Rubot * * :Rubot') #CONFIG: Username, realname
while ($line = $irc_connection.gets) do
  puts "<-- #{$line}"
  rawsend("PONG #{$line.split[1]}") if $line.split[0] == 'PING'
  rawsend("JOIN #{$line.split[3]}") if $line.split[1] == 'INVITE'
end