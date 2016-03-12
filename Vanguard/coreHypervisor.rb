require 'sidekiq'
require 'sidekiq-superworker'
require 'connection_pool'
require 'redis-objects'
require 'mongoid'
require 'mongo'
require 'net/ssh'

require 'rye'
require_relative 'initialization-routines'
require_relative 'vanguard-workers'
require_relative '../Keystone/models/systemicAttrition'
require_relative '../Keystone/models/systemicTitan'
require_relative '../Universe/Gathering/scanning'
require_relative './Keystone/models/user'
p "############################### Vanguard ###################################"
$logger.info "########## VANGUARD ##########"

######################################################################################
## Powerplant Workers Akashic
## Sidekiq.redis is an exposed redis handle, yay!
##   Sidekiq.redis { |conn| conn.del(lock) }
## Sidekiq.logger exposes logging functionality
##  Sidekiq.logger.warm "foo bar"

### Calling Workers

#MyWorker.perform_async(1, 2, 3)
#Sidekiq::Client.push('class' => MyWorker, 'args' => [1, 2, 3])  # Lower-level generic API

#####################################################################################

#### Sidekiq Sueprworker

# Superworker.define(:MySuperworker, :user_id, :comment_id) do
#   Worker1 :user_id
#   Worker2 :user_id do
#     parallel do
#       Worker3 :comment_id do
#         Worker4 :comment_id
#         Worker5 :comment_id
#       end
#       Worker6 :user_id do
#         parallel do
#           Worker7 :user_id
#           Worker8 :user_id
#           Worker9 :user_id
#         end
#       end
#     end
#     Worker10 :comment_id
#   end
# end

## Coordinate all the titan jobs
# class TitanHighCommander(*args)
#
# end


