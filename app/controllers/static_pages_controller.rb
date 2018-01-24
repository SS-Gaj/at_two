class StaticPagesController < ApplicationController
  def news
		@micropost = current_user.microposts.build if signed_in?	#Листинг 10.31
  end

  def anonce
  end

  def article
  end
end
