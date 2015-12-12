
#### Libfatgirl is a utility library for http


## is_valid_ip? takes self as an arg, where self is String class
## Validate IP Address
require 'ipaddress'

class String

def is_valid_ip? 
  IPAddress.valid? self
end

end

