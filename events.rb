class Hook
	def self.hooks
		@hooks ||= []
	end

	def initialize(event, conditions=false, &callback)
		# Add the hook to the list of hooks
		Hook.hooks << { :event => event, :conditions => conditions, :callback => callback }
	end
end

# Syntactic sugar - preferred to Hook.new
def on(event, conditions=false, &callback)
	return Hook.new(event, conditions, &callback)
end

# Syntactic sugar - preferred to on(:command)
def command(command, conditions={}, &callback)
	return Hook.new(:command, conditions.merge({:command => command.to_s}), &callback)
end

def fireevent(event, arguments)
	Hook.hooks.each { |hook|
		if hook[:event] == event
			if !hook[:conditions]
				hook[:callback].call(arguments)
				puts "#{event} hook triggered: #{arguments}"
			else
				fire = true
				hook[:conditions].each do
					|k,v|
					fire = false if arguments[k] != v
				end
				hook[:callback].call(arguments) if fire
				puts "#{event} hook triggered: #{arguments}"
			end
		end
	}
end