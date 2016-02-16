#require 'Rb-inotify'## Monitor Log File for changes
require 'rb-inotify'
module Attrition
class LogChangeDetector
  attr_reader :notifier, :location, :options

  def initialize(location, options={})
    @location = location
    @notifier = INotify::Notifier.new #if is_linux?
    @options = options
   # @proc = proc
    # @notifier = FSEvent.new if  is_mac?
  end

  #
  # Accepts a Proc object containing the code
  # to be executed when a notifier event occurs
  #
  def watch(proc=nil)
    proc = lambda{ |event| puts "Detected change inside: #{event.class}" }
    if proc.nil? and not(proc.kind_of?(Proc))
      if is_mac?
        @notifier.watch([@path]) do |event|
          proc.call(event)
        end
      elsif is_linux? # :delete, :modify, :m :delete, :modify, :moved_to, :createoved_to, :create
        @notifier.watch(@path, :modify, :create) do |event|
          proc.call(event)
        end
      end

    end
  end


  def run
    @notifier.run
  end

  def stop
    @notifier.stop
  end

end
end

b = Attrition::LogChangeDetector.new('testfile.txt', {})
p b.class

