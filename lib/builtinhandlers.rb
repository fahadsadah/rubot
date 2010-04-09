on(:ping) { |e| rawsend("PONG #{e[:token]}")}
on(:invite) { |e| rawsend("JOIN #{e[:channel]}")}