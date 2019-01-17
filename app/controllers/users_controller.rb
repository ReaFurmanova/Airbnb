## in terminal: rails generate controller users
# if I will create model, write just user
# in right directory everything
class UsersController < Clearance::UsersController
	before_action :find_user, only: [:show, :edit, :update]
	
	def show
		#### sem pisu vsechny promenne, kdyz je nenapisu sem, tak bude na strance nil
		@listings = Listing.all.order('created_at DESC').page(params[:page])
		# @listings = Listing.all.order(created_at: :DESC).paginate.(:page => params[:page], :per_page => 10)
		####find najde jedno, where v query najde vice zaznamu
		####kdyz pouziju current_user.id a nekod jiny pujde na stranku uvidi svoje rezervace
		@reservations = Reservation.where(user_id: @user.id)
	end
	
	def create
		# #show me a params????
		# render plain:params[:user].inspect
		user = User.new(params_user)
		# if I have just this line it will give me error , because of strong parameter - requires us to tell Rails exactly which parameters are allowed into our controller actions
		

		if user.save
			sign_in(user)
			flash[:message] = "Saved"
			redirect_to user_path(user.id)
		else
			flash[:message] = "Save wasn't succesful"
			redirect_to sign_up_path
		end	
	end

	def edit
	end

	def update
		if @user.update(params_user)
			redirect_to user_path(@user)
		else
			flash[:message] = "Update was not succesful"
			render 'edit'
		end
	end

	private
	def params_user
		# Strong parameteres - The syntax for this introduces require and permit
		params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
	end	

	def find_user
		# nemuze to byt stejne jako u listingu, kvuli strance kam to odkazuje, bylo to id = nill
		@user = User.find(current_user.id)
	end
end
