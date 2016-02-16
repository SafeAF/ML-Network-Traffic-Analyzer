#!/usr/bin/env ruby
require 'gmail'



class Email
  attr_accessor :mail, :count, :saveFolder, :emails, :unread, :read,
                :todaysMailCount
  attr_reader :username, :password
  def initialize(username='support@baremetalnetworks.com',
                 password='todkjw29347@', saveFolder='./mails')
    @username = username
    @password = password
    @gmail = Gmail.new(username, password)
    @count = @gmail.inbox.count
    @saveFolder = saveFolder
    @emails = []
    @unread = @gmail.inbox.count(:unread)
    @read = @gmail.inbox.count(:read)
    @todaysMailCount = @gmail.inbox.count(:on => Date.parse("2010-04-15"))
  end

  def save_attachments(in_label='primary', folder=@saveFolder)
    @gmail.mailbox(in_label).mails.each do |mail|
      mail.attachments.each do |attachment|
        file = File.new(folder + attachment.filename, "w+")
        file << attachment.decoded
        file.close
      end
    end
  end

# input: (date) : "2010-02-02", (sender) : "bob@example.com"
  def mark_as_read_archive(date, sender)
    @gmail.inbox.mails(:before => Date.parse(date),
                     :from => sender).each do |mail|
      mail.mark(:read) # can also mark :unread or :spam
      mail.archive!
    end
  end

  def delete_mails(sender)
    @gmail.inbox.mails(:from => sender).each do |mail|
      mail.delete!
    end
  end

  def counts(from, to)
#    mail.inbox.count(:unread, :from => "myboss@mail.com")

# Count with some criteria
#mail.inbox.count(:after => Date.parse("2010-02-20"), :before => Date.parse("2010-03-20"))
    if from
      return @gmail.inbox.count(:from => from)
    elsif to
      return @gmail.inbox.count(:to => "directlytome@mail.com")
    end
  else
    return nil
  end

end


# Combine flags and options

# Labels work the same way as inbox
mail.mailbox('Urgent').count

# Getting messages works the same way as counting: optional flag, and optional arguments
# Remember that every message in a conversation/thread will come as a separate message.
mail.inbox.mails(:unread, :before => Date.parse("2010-04-20"), :from => "myboss@mail.com")

# Get messages without marking them as read on the server.
mail.peek = true
mail.inbox.mails(:unread, :before => Date.parse("2010-04-20"), :from => "myboss@mail.com")

__END__
class GMailer
 attr_accessor :api

  def initialize(username, password)
    @api = Gmail.new(username, password)
  end


  def logout
    @api.logout
  end

  def count_unread()
    @api.inbox.count(:unread)
  end



end

username = 'support@baremetalnetworks.com'
password = 'todkjw29347@'

mail = GMailer.new(username, password)
p mail
p mail.api
p mail.api.inbox.countmail.deliver do
  to "mail@example.com"
  subject "Having fun in Puerto Rico!"
  text_part do
    body "Text of plaintext message."
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Text of <em>html</em> message.</p>"
  end
  add_file "/path/to/some_image.jpg"
end
# Or, generate the message first and send it later
mail = mail.generate_message do
  to "mail@example.com"
  subject "Having fun in Puerto Rico!"
  body "Spent the day on the road..."
end
mail.deliver!
# Or...
mail.deliver(mail)