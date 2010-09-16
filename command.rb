on :privmsg do
	|e|
	if e[:message].split[0][0].chr == $config['command']['trigger']
		arguments = e
		arguments[:arguments] = arguments[:message].split(' ',2)[1]
		arguments[:command] = arguments[:message].split(' ',2)[0][1..-1]
		fireevent(:command, arguments)
	end
end