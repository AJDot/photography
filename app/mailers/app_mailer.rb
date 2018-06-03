class AppMailer < ActionMailer::Base
  default from: 'info@tracysphotostudio.com'
  layout 'mailer'

  def book_me(client)
    @client = client
    mail to: 'tracy@example.com',  subject: "#{@client.name} filled out the \"Book Me\" form."
  end

  def contact_me(client)
    @client = client
    mail to: 'tracy@example.com',  subject: "#{@client.name} filled out the \"Contact Me\" form."
  end
end
