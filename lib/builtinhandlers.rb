on(:ping, proc { |e| rawsend("PONG #{e[:token]}")})
on(:invite, proc { |e| rawsend("JOIN #{e[:channel]}")})