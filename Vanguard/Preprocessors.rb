require 'sidekiq'

class ApacheLogPreProcessor
  include Sidekiq::Worker

  def perform(params)
    @logs = params[:logfile]
  end
end

class SyslogLogPreProcessor
  include Sidekiq::Worker

  def perform(params)
    @logs = params[:logfile]
  end
end

class SshLogPreProcessor
  include Sidekiq::Worker

  def perform(params)
    @logs = params[:logfile]
  end
end

class ClutchLogPreProcessor
  include Sidekiq::Worker

  def perform(params)
    @logs = params[:logfile]
  end
end


module Attrition
  module Log


    class Preprocessor
      include Sidekiq::Worker
      include Mongoid::Document

      #field logs, type: Array
      def perform(*args)

      end

    end


  end
end

