class DocCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  after_save :clear_cache ## FIXME ## Use cache_observers in production

  # expire stale cache stored in redis (on systemstack @ stack0)
  def clear_cache
    $redis.del "categories"
  end
  include CommonMeta
end
