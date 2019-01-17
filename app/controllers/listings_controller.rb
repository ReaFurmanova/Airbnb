class ListingsController < ApplicationController
	
	before_action :find_listing, only: [:show, :edit, :update, :destroy, :verify]


	def show
		@reservations = Reservation.where(listing_id: @listing.id)
	end

	def new
		@listing = Listing.new
	end
	# when in console terminal (rails c) I will use something.new i need to do something.save
	# even I use something.create it will automaticly saved
	def create
		@listing = Listing.create(params_listing)
		@listing.user = current_user
		if @listing.save
			redirect_to @listing
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		
		if @listing.update (params_listing)
			redirect_to listing_path(@listing)
		else
			flash[:message] = "Update was not succesful"
			render 'edit'
		end
	end

	def destroy
		@listing.destroy
		redirect_to root_path
	end

	def verify
		puts"++++++++++++++++++++++++++++++++"
		if current_user.admin?
			p @listing.verified
			@listing.verified = true
			@listing.save
			p @listing.verified
		else
			flash[:message] = "Sorry. You are not allowed to perform this action"
		end
		redirect_to listing_path(@listing)
	end


	private
	def params_listing
		params.require(:listing).permit(:title, :text, :pets, :verified, :initial_picture)
	end

	def find_listing
		@listing = Listing.find(params[:id])
	end
end
