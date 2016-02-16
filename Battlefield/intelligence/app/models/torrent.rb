class Torrent < ActiveRecord::Base
  belongs_to :server
  belongs_to :application
end
