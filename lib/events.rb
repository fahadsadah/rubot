class Hook
  def self.hooks
    @hooks ||= []
  end

  def initialize(event, &callback)
    # Add the hook to the list of hooks
    Hook.hooks << { :event => event, :callback => callback }
  end
end

# This is only a shortcut
def on(*args)
  return Hook.new(*args)
end

def fireevent(event, arguments)
  Hook.hooks.each { |hook|
    if hook[:event] == event
      hook[:callback].call(arguments)
    end
  }
end
