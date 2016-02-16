

class FSChangeDetection
  attr_reader :notifier

  def initialize(location, options={})
    @location = location
    if /linux/.match( RUBY_PLATFORM.downcase);  is_linux = true; end
    if /darwin/.match( RUBY_PLATFORM.downcase);  is_mac = true; end
    @notifier = INotify::Notifier.new if is_linux
    @notifier = FSEvent.new if  is_mac
  end

  #
  # Accepts a Proc object containing the code
  # to be executed when a notifier event occurs
  #
  def watch(proc=nil)
    proc=lambda{ |event| puts "Detected change inside: #{event.class}" } unless proc
    if proc.nil? and not(proc.kind_of?(Proc))
      if is_mac
        @notifier.watch([@path]) do |event|
          proc.call(event)
        end
      elsif is_linux
        @notifier.watch(@path, :moved_to, :create) do |event|
          proc.call(event)
        end
      end
      puts "Watching #{@path}"
    end
  end


  def run
    @notifier.run
  end

  def stop
    @notifier.stop
  end
end