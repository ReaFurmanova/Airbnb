class ReservationJob < ApplicationJob
  queue_as :default
  
  ####ODTUD TO JDE DO PAYMENT CONTROLER, PROTOZE POSILAM EMAIL PRI PLACENI
####vstupuje current_user
  def perform(user)
    ReservationMailer.reservation_email(user).deliver_now
  end
end
 

