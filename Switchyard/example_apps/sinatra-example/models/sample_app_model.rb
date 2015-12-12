require './config/sample_app_config'

class SampleAppModel

  include Mongoid::Document
  field :some_attr, type: String
end