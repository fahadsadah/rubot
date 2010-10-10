$ISUPPORT = {}
def process_005(params)
	retval = {}
	params.each do
		|param|
		punct = Regexp.escape '!"#$%&\'()*+,-./:;<=>?@[]^_`{|}~'
		regexp1 = Regexp.new("[A-Z0-9]+=[a-zA-Z0-9#{punct}]+")
		regexp2 = Regexp.new("[A-Z0-9]+")
		regexp3 = Regexp.new("[A-Z0-9]+=")
		regexp4 = Regexp.new("-[A-Z0-9]+")
		if regexp1 =~ param #K=V
			k = param.split('=',2)[0]
			v = param.split('=',2)[1]
			retval[k] = v
		elsif regexp2 =~ param #K
			retval[param] = true
		elsif regexp3 =~ param #K=
			retval[param[0..-2]] = true
		elsif regexp4 =~ param #-K
			retval[param[1..-1]] = false
		end
	end
	return retval
end

on(:line) do
	|e|
	if e[:line].split[1] == '005'
		#remove front
		line = e[:line].split(' ', 4)[3]
		
		params = []
		
		line.split.each do
			|param|
			break if /:[\w]+/ =~ param
			
			params << param
		end
		
		$ISUPPORT.merge! process_005 params
	end
end

#default ISUPPORT header for RFC1459-compliant servers.
$ISUPPORT.merge! process_005 "CASEMAPPING=rfc1459 CHANNELLEN=200 CHANTYPES=#& MODES=3 NICKLEN=9 PREFIX=(ov)@+ TARGMAX"