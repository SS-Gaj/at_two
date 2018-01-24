class MicropostsController < ApplicationController
  before_action :signed_in_user

  def create	#Листинг 10.27
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			render 'static_pages/news'
		end
  end

  def destroy
  end

	private

	def micropost_params	#Листинг 10.27
		params.require(:micropost).permit(:content)
	end
end
