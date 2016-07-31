

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})}


$redisLogservTable = 'yard:logserver'
$LOGSERV = Redis::List.new($redisLogservTable, :marshal => true)
# transport to bloodlust
$redisBloodlustConnector = 'yard:connector'
$BLOODCONN =   Redis::List.new($redisBloodlustConnector, :marshal => true)
$redisAttritionAuthTable = 'attrition:apiauthtable'
$AUTHTABLE = Redis::List.new($redisAttritionAuthTable, :marshal => true)



class SwitchKiqPost
  include Sidekiq::Worker
  include Redis::Objects

  def id

  end

  def perform(name, count)
    # do something
    $BLOODCONN.values.pop
    end
  #ism_async('bob', 5)

    end