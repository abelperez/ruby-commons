
class EmailGateway

    def send(from, from_alias, to, to_alias, subject, message)
      send_email(from, from_alias, to, to_alias, subject, message)
    end
    
    def send_email(from, from_alias, to, to_alias, subject, message)
	msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to_alias} <#{to}>
Subject: #{subject}
	
#{message}
END_OF_MESSAGE
	
	Net::SMTP.start('localhost') do |smtp|
		smtp.send_message msg, from, to
	end
    end
end

