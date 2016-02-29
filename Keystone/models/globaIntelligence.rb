class GlobalIP
  include Mongoid::Document
  include Redis::Objects
  include Mongoid::Timestamps

  field :address, type: String
  field :organization, type: String
  field :codename, type: String
  field :domains, type: Array
  field :geoloc, type: String
  field :whois
  field :reverselookup
  field :changeInReputation, type: Float
  field :valid, type: Boolean

  has_one :banStatus, autosave: true
#

end