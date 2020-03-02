class Users::UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update]

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "プロフィールを更新しました。"
	      	render :update
	     else
	     	render :edit
	     end
	end

	private

	def correct_user
		#@userとcurrent_userが同じで無ければプロフィールの編集更新はできない
		@user = User.find(params[:id])
		if current_user != @user
			redirect_to root_path
		end
    end

	def user_params
	    params.require(:user).permit(:name, :email, :profile_image)
	end
end
