class AppMailer < ActionMailer::Base
  default from: 'info@tracysphotostudio.com'
  layout 'mailer'

  def book_me(client)
    @client = client
    mail to: 'tracy@example.com',  subject: "#{@client.name} sent you a message."
  end
end
