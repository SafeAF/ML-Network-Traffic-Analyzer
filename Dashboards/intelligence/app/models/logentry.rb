class Logentry < ActiveRecord::Base
  belongs_to :logfile
  belongs_to :service
  belongs_to :logentry
end
