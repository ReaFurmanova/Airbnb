## in terminal: rails generate controller users
# if I will create model, write just user
# in right directory everything
class UsersController < ApplicationController

	def show	
	end

	def create
		# #show me a params????
		# render plain:params[:user].inspect
		user = User.new(params_user)
		# if I have just this line it will give me error , because of strong parameter - requires us to tell Rails exactly which parameters are allowed into our controller actions
		if user.save
			sign_in(user)
			# flash[:message] = "Saved"
			redirect_to user_path(user.id)
		else
			flash[:message] = "Save wasn't succesful"
			redirect back
		end	
	end

	private
	def params_user
		# Strong parameteres - The syntax for this introduces require and permit
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end	
end
