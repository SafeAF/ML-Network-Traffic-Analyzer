class Label  < ActiveRecord::Base
  include Redis::Objects
#  belongs_to :issuelist
  belongs_to :issue
  belongs_to :task
  belongs_to :tasklist

  end
