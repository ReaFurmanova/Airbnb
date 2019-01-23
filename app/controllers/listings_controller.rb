class ListingsController < ApplicationController
	
	before_action :find_listing, only: [ :show, :edit, :update, :destroy, :verify]
	####index to bzt nemusi, protoze je pro vsechny indexy, kdyz tu je, mam chybu, Couldn't find Listing without an ID


	def show
		@reservations = Reservation.where(listing_id: @listing.id)
		# @listing = Listing.search(params[:search], params[:city])

	end

	def index
		@listings = Listing.all
		if params[:city].present?
	    	@listings = @listings.city(params[:city])
  		end
  		# if params[:price].present?
	   #  	@listings = @listings.price(params[:price])
  		# end
  		if params[:min].present?
	    	@listings = @listings.price_min(params[:min])
	    	####v modelu ve scope se to muze jmenovat jinak abc, posilam tam cislo ktere uzivatel zadal do policka min
  		end
  		if params[:max].present?
	    	@listings = @listings.price_max(params[:max])
  		end
  		if params[:pool] == '1'
	    	@listings = @listings.pool
  		end
  		if params[:pets] == '1'
	    	@listings = @listings.pets
  		end
  		if params[:home_type].present?
	    	@listings = @listings.home_type(params[:home_type])
	    	####params here goes to model listing
  		end
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
		#### jednotlivy parametr muze jit ven, kdybych mela vsecky, nekdo muze pres inspect stranku, zjistit moje parametry, protoze asi budu mit user_id = 2
		#nazev obrazku nevi...?
		if @listing.update (params_listing)
			if params[:listing][:images].present?
				#toto oboje je array, muzu je jen secist
				@listing.images = @listing.images + params[:listing][:images]
				#update samotny ulozi zaznam, jestli menim neco jeste potom musim znovu ulozit
				@listing.save
			end
			redirect_to listing_path(@listing)
		else
			#### flash message muze byt jen jedna (zobrazi to jen jednu)
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
		params.require(:listing).permit(:title, :text, :country, :city, :pool, :price, :home_type, :pets, :verified)
	end

	def find_listing
		@listing = Listing.find(params[:id])
	end
end
