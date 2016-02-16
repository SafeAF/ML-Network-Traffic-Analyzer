class Ban < ActiveRecord::Base
# attr_accessor :ip, :location, :reason, :duration, :gucid, :host_lookup
 # named_scope :created_after, lambda {|date| {:conditions => ["created_at > ?", date]}}
	 belongs_to :machine
	 belongs_to :server
# TODO: Implement transactions to prevent collisions between switchyard
# TODO: clusters and possibly kimberlite

before_validation :ensure_ip_is_not_in_rfc1918_space

	def ensure_ip_is_not_in_rfc1918_space
		return if ip.nil?
		c = ip.split('.')

		if c[0] =~ /^172/ and (16..31)===c[1].to_i
			self.ip = ''

		elsif c[0] =~ /^192/ and c[1] =~ /168/
			self.ip = ''

		elsif ip =~ /^10\.[0-255]+\.[0-255]+\.[0-255]+/
			self.ip = ''
		end
	end


@ip_regex = /\A([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}\z/

validates :ip, 
        # :presence => true, 
        # :uniqueness => true,
          :format => { :with => @ip_regex } 

#validates :ip, :format => { :with => /^[^1][^0]/ }
#validates :ip, :format => { :with => /^[^172]\.[16]+\.[0-9]+\.[0-9]+$/ }
#validates_with RFC1918Validator, :fields => [:ip]

# TODO: Googles ip, Root DNS servers ips
# 127.0.0.1
# 10.0.0.0        -   10.255.255.255  (10/8 prefix)
# 172.16.0.0      -   172.31.255.255  (172.16/12 prefix)
# 192.168.0.0     -   192.168.255.255 (192.168/16 prefix)

  class RFC1918Validator < ActiveModel::Validator
    def validate(record)
      record.name          # Access the ActiveRecord model
      options[:fields]     # Access the options passed to the validator
		errors.add(:ip, "can't be a RFC1918 private IP address") if ip =~ /10\.[0-9]+\.[0-9]+\.[0-9]+/
    end
  end

# validate :account_name, :account_description

#  def account_name
#    errors.add(:user_name, "can't be blank") if user_name.blank?
#  end



	# TODO: put in validations that prevent private ip addresses and ips of major 
	# like root dns to prevent DOS attacks against our clients using our ban
	# list

	# TODO: each different service monitored needs its own ban list, or 
	# if the banlists are all intermingled there should be a field
	# in the db that states which service the ban is for

	# TODO: Pull in ips from public blacklists like 
	# rules.emerginthreats.net/fwrules/emerging-block-ips.txt
	# labs.snort.org/iplists
	# dshield.org spamhaus.org shadowserver.org

end
