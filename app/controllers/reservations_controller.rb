####rails generate controller name
class ReservationsController < ApplicationController
	before_action :find_reservation, only: [:show, :edit, :update, :destroy]
	
	def new
		reservation = Reservation.new
		####TOHLE SE TVORI AUTOMATICKY KDYZ MAM FUNKCI NEW A CHCE TO NOVOU STRANKU
		# respond_to do |format|
		# 	format.html
		# end
	end

	def create

		reservation = Reservation.new(params_reservation)
		#### musim pridat tyto dva radky, jinak budu mit chybu, ze program nevi, what is user id a listing id
		#### I have curent_user.id but there is nothing as current_listing.id(pokud si to nenadefinuji, neni tam ted)
		today = Date.today
		if reservation.arrival >= today			
			# @listing = Listing.find(params[:listing_id])
			
			reservation.user_id = current_user.id
			#### params jsem si nasla pres byebug
			reservation.listing_id = params[:listing_id]
			reservation.amount = (reservation.departure - reservation.arrival) * reservation.listing.price
			####fpri byebug promenna.errors ukaze mi, kde je chyba, byla v reservation.save
			#byebug
			####save give me true/false, proto muzu pouzit if else
		else
			flash[:message] = "Date can not be in past"
			return
		end
		####do ktereho controleru (prvni jsem to mela v listings, budu psat kdyz si pres inspect stranky najdu format a tam je psana action, pak pres routes si najdu kam to je napojene a tam dam respond_to)
		respond_to do |format|

			if reservation.save
				#### vyse current_user to je duvod proc mas cur_user also dole, jde to
				# ReservationJob.perform_later(current_user)
				# Tell the ReservationMailer to send a email after save
				#### this function call def reservation_email in ReservationMailer, it is reason why is there current_user

				####move to payment controler
				# ReservationMailer.reservation_email(current_user).delivery_now
				####je taky delivery_later

				####protoze mam ajax na strance, neaktualizuji stranku a flash message se mi objevi napr az na homepage, to je duvod proc mam zakomentovany flash message

				#flash[:message] = "Booked"
				# why it is appear on profile page and not here ==========================================
				
				format.html
				#### promenna = prave vytvorena rezervace, pres ni ziskam id listingu a kouknu jake vsechny rezervace listing ma
				@reservations = reservation.listing.reservations
				####musim vytvorit novy nahled v reservation#create, protoze jsem ve funkci create
				format.js
			else
				#flash[:message] = "Reservation was not performed"
			end
		end
	end

	def destroy
		@reservation.destroy
		redirect_to root_path
	end

	private

	def params_reservation
		params.require(:reservation).permit(:user, :listing, :arrival, :departure)
	end

	def find_reservation
		@reservation = Reservation.find(params[:id])
	end

end
