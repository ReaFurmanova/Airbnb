class PaymentController < ApplicationController

  	def new
  		####mela jsem chybu tu, protoze muj config se jmenoval payment, musi se jmenovat braintree, protoze logika gemu braintree
 	 	@client_token = Braintree::ClientToken.generate
	end

	def checkout
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => "10.00", #this is currently hardcoded
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	    redirect_to :root, :flash => { :success => "Transaction successful!" }
	  else
	    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
	  end
	end
end

