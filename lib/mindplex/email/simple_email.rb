
module System
  
  # Notification sender address
  FROM_ADDRESS = 'system@mindplexmedia.com'
  FROM_ADDRESS_ALIAS = 'Mindplex System'
  
  def notify(recipient, subject, message)
	  msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{recipient} <#{recipient}>
Subject: #{subject}
	
#{message}
END_OF_MESSAGE
	
	  Net::SMTP.start('localhost') do |smtp|
		  smtp.send_message msg, from, to
	  end
  end
end
