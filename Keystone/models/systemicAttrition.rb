require 'mongoid'

module Systemic

  module Attrition

    class BloodlustMachineLearning
      include Mongoid::Document
      # include Redis::Objects

      field :name, type: String
      field :training_memory, type: String
      field :frozenbloodlust, type: String
      field :bloodlust_id, type: Integer
      field :service, type: String
      field :library, type: String
      field :operating_efficiency, type: Float
      field :false_positives, type: Float
      field :false_negatives, type: Float
      field :ops_per_sec
      field :id, type: Integer

      def id ; @id ; end

      def id=
        @id = SecureRandom.hex(12)
      end
      #
      # def self.defer
      #   perform_async
      #   sidekiq_options :retry => 25, :dead => true, :queue => syslog
      # end
      #
    end

  end

  class ApacheLog
    include Mongoid::Document
    include Redis::Objects
    include Mongoid::Timestamps

    field :name
    field :type

  end

  class SysLog
    include Mongoid::Document
    include Redis::Objects
    include Mongoid::Timestamps

    field :id
    field :created
    field :updated
    field :logged, type: Datetime
    field :logfileID, type: Integer
    field :name
    field :message
    field :facility
    field :priority, type: Integer
    field :service
    field :serviceID, type: Integer
    field :logentryID, type: Integer
  end

end

