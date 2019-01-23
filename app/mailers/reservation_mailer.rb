class ReservationMailer < ApplicationMailer
	# default from: "reafurmanova@gmail.com"

	#### TADY VYTVORIM EMAIL, jde to do reservation_job

	#### OBYCEJNY
	####(user) is from controller- ReservationMailer.reservation_email(current_user).delivery_now
	def reservation_email(user)
		@user = user
		@url = 'http://localhost:3000/payment/new'
		#### ted to mam na stranku placeni, ale nemusi zaplatit????
		mail(to: @user.email, subject: "Confirmation of your reservation")
	end
	#### SE JMENEM
	# def reservation_email(user)
	# 	  @user = current_user
	# 	  @url = 'http://localhost:3000/payment/new'
	# 	  email_with_name = %("#{@user.first_name}" <#{@user.email}>)
	# 	  mail(to: email_with_name, subject: 'Confirmation of your reservation')
	# end
	

	# def receive(email)
	# page = Page.find_by(address: email.to.first)
	# page.emails.create(
	#   subject: email.subject,
	#   body: email.body
	# )
	# 	if email.has_attachments?
	# 	  email.attachments.each do |attachment|
	# 	    page.attachments.create({
	# 	      file: attachment,
	# 	      description: email.subject
	# 	    })
	# 	  end
	# 	end
	# end
end
