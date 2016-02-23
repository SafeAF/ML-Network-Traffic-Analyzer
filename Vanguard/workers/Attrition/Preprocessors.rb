

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

