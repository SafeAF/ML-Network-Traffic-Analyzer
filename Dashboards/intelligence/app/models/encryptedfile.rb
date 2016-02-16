class Encryptedfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :server
  belongs_to :vfilesystem
end
