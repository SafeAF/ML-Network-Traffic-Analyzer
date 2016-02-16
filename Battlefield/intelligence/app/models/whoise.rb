class Whoise < ActiveRecord::Base
  belongs_to :url
  belongs_to :ip
end
