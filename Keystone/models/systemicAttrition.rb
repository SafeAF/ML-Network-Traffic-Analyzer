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

  class Preprocessor
    include Mongoid::Document

    field :name
    field :type

  end

  class

end

