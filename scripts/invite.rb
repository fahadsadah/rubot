on :invite do
	|e|
	if $config['invite']['join']
		rawsend("JOIN #{e[:channel]}")
		if $config['invite']['announce']
			message = $config['invite']['message'].sub('$nick',e[:nick]).sub('$chan',e[:channel])
			rawsend("PRIVMSG #{e[:channel]} :#{message}")
		end
	end
end