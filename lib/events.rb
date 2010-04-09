class Hook
  @@hooks = Array.new
  def self.hooks
    @@hooks
  end
  def initialize(event, &callback)
    #Add the hook to the list of hooks
    @@hooks << {:event => event, :callback => callback}
  end
end
#This is only a shortcut
def on(event, callback)
  return Hook.new(event, callback)
end

def fireevent(event, parameters)
  Hook.hooks.select { |hook| hook[:event] == event }.each { |hook| hook[:callback].call(parameters) }
end