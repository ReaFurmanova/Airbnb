####rails generate controller name
class ReservationsController < ApplicationController
	before_action :find_reservation, only: [:show, :edit, :update, :destroy]
	
	def new
		reservation = Reservation.new
	end

	def create
		reservation = Reservation.new(params_reservation)
		#### musim pridat tyto dva radky, jinak budu mit chybu, ze program nevi, what is user id a listing id
		#### I have curent_user.id but there is nothing as current_listing.id(pokud si to nenadefinuji, neni tam ted)
		
		# @listing = Listing.find(params[:listing_id])
		
		reservation.user_id = current_user.id
		#### params jsem si nasla pres byebug
		reservation.listing_id = params[:listing_id]
		# reservation.listing_id =  
		####fpri byebug promenna.errors ukaze mi, kde je chyba, byla v reservation.save
		#byebug
		####save give me true/false, proto muzu pouzit if else
		if reservation.save
			flash[:message] = "Booked"
			# why it is appear on profile page and not here ==========================================
		else
			flash[:message] = "Reservation was not perform"
		end
	end

	def destroy
		@reservation.destroy
		redirect_to root_path
	end

	private

	def params_reservation
		params.require(:reservation).permit(:user, :listing, :country, :city, :arrival, :departure)
	end

	def find_reservation
		@reservation = Reservation.find(params[:id])
	end

end
