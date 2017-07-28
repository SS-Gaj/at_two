class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      #redirect_to user     #удалено в   Листинг 9.19.
      redirect_back_or user #добавлено в Листинг 9.19. Действие create контроллера Sessions с дружелюбной переадресацией.
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
