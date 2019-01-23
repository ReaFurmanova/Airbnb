class PaymentsController < ApplicationController
	before_action :find_reservation

  	def new
  		####mela jsem chybu tu, protoze muj config se jmenoval payment, musi se jmenovat braintree, protoze logika gemu braintree
 	 	@client_token = Braintree::ClientToken.generate
	end

	def checkout
	  	nonce_from_the_client = params[:checkout_form][:payment_method_nonce]


		  result = Braintree::Transaction.sale(
		   :amount => @reservation.listing.price,
		   # :amount => "1.00", #this is currently hardcoded (reservation.listing.price konec date - start date)
		   :payment_method_nonce => nonce_from_the_client,
		   :options => {
		      :submit_for_settlement => true
		    }
		   )

		  if result.success?

		  	redis_available = true
			Sidekiq.redis do |connection|
			  begin
			    connection.info
			  rescue Redis::CannotConnectError
			    redis_available = false
			  end
			end


			if redis_available
			    ReservationJob.perform_later(current_user)
			end

		    ####neznalo to @rezervation because I hadnt nested routes
		    #in nested routes I have id predchozich
		    #nemam nested musim rict parametry in new payment
		    @reservation.state_payment = true
		    @reservation.save
			redirect_to :root, :flash => { :success => "Transaction successful!" }
		    ####TUHLE VARIANTU TU MAM KDYZ NEMAM RESERVATION_JOB(POSLE EMAIL HNED,LATER)
		    # ReservationMailer.reservation_email(current_user).deliver_later
		    #### presunuto do reservation_job

		    #### kdyz mam deliver_now a melo by to posilat vice emailu najednou muze to zpomalovat pocitac
		    #### proto pouziju delivery_later
		    ####v pripade, ze to bude jen jeden email muzu hned
		    ####Goldie je zlato/a, ja rozdil v rychlosti nezaznamenala a uz bych se mela konecne rozhodnout, jestli jee to ten nebo ta
		  else
		    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
		  end
	end
	private
	def find_reservation
		@reservation = Reservation.find(params[:reservation_id])
	end
end

