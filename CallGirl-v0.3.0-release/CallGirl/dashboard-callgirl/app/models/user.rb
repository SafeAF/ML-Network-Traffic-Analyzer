class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin, :devops, :ops, :dev]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


         	include Redis::Objects

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
#	devise :database_authenticatable, :registerable,
#	       :recoverable, :rememberable, :trackable, :validatable,
	#       :confirmable, :lockable, :timeoutable


 has_and_belongs_to_many :roles
 has_many :machines
	has_and_belongs_to_many :clusters
	has_many :servers

# protect these with :attr_protected
# attr_accessible :name, :password, :password_confirmation, :fullname,
#	:email, :company, :address1, :address2, :city, :state, :zip, 
#	:country, :phone, :captcha, :captcha_key

	## TODO FIX THIS ## Maybe use ruby-recaptcha from apt
# apply_simple_captcha :message => "is invalid"

# validates_presence_of     :name
# validates_uniqueness_of   :name
 # validates :name, presence: true, uniqueness: true
 
# attr_accessor :password_confirmation
# validates_confirmation_of :password
# validate :password_non_blank
# validates_format_of :email,
# :with => /\A\z|\A\S+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,4}|[0-9]{1,4})(\]?)\z/ix
  
 #validates_presence_of	:fullname
# validates_format_of	:fullname,
#	:with => /^\w+\ \w$/, :message => "must be alphabetic"
# validates_presence_of	:company
# validates_presence_of	:address1
# validates_presence_of	:city
# validates_presence_of	:state
# validates_format_of	 :state,
#	:with => /\A[A-Z]{2}\z/, :message => 'must be a valid state.'
 STATES = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA',
	'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA',
	'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY',
	'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX',
	'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY']
# validates_presence_of	:zip
# validates_format_of	:zip,
#	:with => /\A\d{5}\z/
# validates_presence_of	:country
 COUNTRIES = ["Afghanistan ", "\303\205land Islands ", "Albania ", 
	"Algeria ", "American Samoa ", "Andorra ", "Angola ", "Anguilla ", 
	"Antarctica ", "Antigua and Barbuda ", "Argentina ", "Armenia ", 
	"Aruba ", "Australia ", "Austria ", "Azerbaijan ", "Bahamas ", 
	"Bahrain ", "Bangladesh ", "Barbados ", "Belarus ", "Belgium ", 
	"Belize ", "Benin ", "Bermuda ", "Bhutan ", 
	"Bolivia, Plurinational State of ", 
	"Bonaire, Sint Eustatius and Saba ", "Bosnia and Herzegovina ", 
	"Botswana ", "Bouvet Island ", "Brazil ", 
	"British Indian Ocean Territory ", "Brunei Darussalam ", "Bulgaria ", 
	"Burkina Faso ", "Burundi ", "Cambodia ", "Cameroon ", "Canada ", 
	"Cape Verde ", "Cayman Islands ", "Central African Republic ", 
	"Chad ", "Chile ", "China ", "Christmas Island ", 
	"Cocos (Keeling) Islands ", "Colombia ", "Comoros ", "Congo ", 
	"Congo, the Democratic Republic of the ", "Cook Islands ", 
	"Costa Rica ", "C\303\264te d'Ivoire ", "Croatia ", "Cuba ", 
	"Cura\303\247ao ", "Cyprus ", "Czech Republic ", "Denmark ", 
	"Djibouti ", "Dominica ", "Dominican Republic ", "Ecuador ", 
	"Egypt ", "El Salvador ", "Equatorial Guinea ", "Eritrea ", 
	"Estonia ", "Ethiopia ", "Falkland Islands (Malvinas) ", 
	"Faroe Islands ", "Fiji ", "Finland ", "France ", "French Guiana ", 
	"French Polynesia ", "French Southern Territories ", "Gabon ", 
	"Gambia ", "Georgia ", "Germany ", "Ghana ", "Gibraltar ", "Greece ", 
	"Greenland ", "Grenada ", "Guadeloupe ", "Guam ", "Guatemala ", 
	"Guernsey ", "Guinea ", "Guinea-Bissau ", "Guyana ", "Haiti ", 
	"Heard Island and McDonald Islands ", "Holy See (Vatican City State) ",
	 "Honduras ", "Hong Kong ", "Hungary ", "Iceland ", "India ", 
	"Indonesia ", "Iran, Islamic Republic of ", "Iraq ", "Ireland ", 
	"Isle of Man ", "Israel ", "Italy ", "Jamaica ", "Japan ", "Jersey ", 
	"Jordan ", "Kazakhstan ", "Kenya ", "Kiribati ", 
	"Korea, Democratic People's Republic of ", "Korea, Republic of ", 
	"Kuwait ", "Kyrgyzstan ", "Lao People's Democratic Republic ", 
	"Latvia ", "Lebanon ", "Lesotho ", "Liberia ", "Libya ", 
	"Liechtenstein ", "Lithuania ", "Luxembourg ", "Macao ", 
	"Macedonia, the former Yugoslav Republic of ", "Madagascar ", 
	"Malawi ", "Malaysia ", "Maldives ", "Mali ", "Malta ", 
	"Marshall Islands ", "Martinique ", "Mauritania ", "Mauritius ", 
	"Mayotte ", "Mexico ", "Micronesia, Federated States of ", 
	"Moldova, Republic of ", "Monaco ", "Mongolia ", "Montenegro ", 
	"Montserrat ", "Morocco ", "Mozambique ", "Myanmar ", "Namibia ", 
	"Nauru ", "Nepal ", "Netherlands ", "New Caledonia ", "New Zealand ", 
	"Nicaragua ", "Niger ", "Nigeria ", "Niue ", "Norfolk Island ", 
	"Northern Mariana Islands ", "Norway ", "Oman ", "Pakistan ", "Palau ",
	 "Palestinian Territory, Occupied ", "Panama ", "Papua New Guinea ", 
	"Paraguay ", "Peru ", "Philippines ", "Pitcairn ", "Poland ", 
	"Portugal ", "Puerto Rico ", "Qatar ", "R\303\251union ", "Romania ", 
	"Russian Federation ", "Rwanda ", "Saint Barth\303\251lemy ", 
	"Saint Helena, Ascension and Tristan da Cunha ", 
	"Saint Kitts and Nevis ", "Saint Lucia ", 
	"Saint Martin (French part) ", "Saint Pierre and Miquelon ", 
	"Saint Vincent and the Grenadines ", "Samoa ", "San Marino ", 
	"Sao Tome and Principe ", "Saudi Arabia ", "Senegal ", "Serbia ", 
	"Seychelles ", "Sierra Leone ", "Singapore ", 
	"Sint Maarten (Dutch part) ", "Slovakia ", "Slovenia ", 
	"Solomon Islands ", "Somalia ", "South Africa ", 
	"South Georgia and the South Sandwich Islands ", "South Sudan ", 
	"Spain ", "Sri Lanka ", "Sudan ", "Suriname ", 
	"Svalbard and Jan Mayen ", "Swaziland ", "Sweden ", "Switzerland ", 
	"Syrian Arab Republic ", "Taiwan, Province of China ", "Tajikistan ", 
	"Tanzania, United Republic of ", "Thailand ", "Timor-Leste ", "Togo ", 
	"Tokelau ", "Tonga ", "Trinidad and Tobago ", "Tunisia ", "Turkey ", 
	"Turkmenistan ", "Turks and Caicos Islands ", "Tuvalu ", "Uganda ", 
	"Ukraine ", "United Arab Emirates ", "United Kingdom ", 
	"United States ", "United States Minor Outlying Islands ", 
	"Uruguay ", "Uzbekistan ", "Vanuatu ", 
	"Venezuela, Bolivarian Republic of ", "Viet Nam ", 
	"Virgin Islands, British ", "Virgin Islands, U.S. ", 
	"Wallis and Futuna ", "Western Sahara ", "Yemen ", "Zambia ", 
	"Zimbabwe "]



	## Support for find :first depracated gone in 3.2, use find.first find.all
 	def machine_avail?
		machine = self.machines.find(:first, :conditions =>
			["installed = ? and cid = ?", false, 'none'])
		if machine
			return machine
		else
			return false
		end
	end

private




  
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end


  ## TODO ##
	## FIXME ## Looks like SHA1 is broked here, needs 'key' and string now
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
end
