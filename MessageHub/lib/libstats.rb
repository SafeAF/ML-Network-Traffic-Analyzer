
module Statistics
 class Messages
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end

 class Notifications
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end

 class Alerts
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end

 class Emails
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end
end
