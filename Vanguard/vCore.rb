require 'sidekiq'

class CoreWorker
  include Sidekiq::Worker

  def perform(operation, *data)
    op = eval(operation).to_proc
    data.map {|datum| op.call}


  end
end