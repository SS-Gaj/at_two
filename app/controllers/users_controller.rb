class UsersController < ApplicationController
#Листинг 10.24. Перемещение метода signed_in_user в Sessions хелпер. 
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy] # :index добавлено в Листинг 9.21; :destroy - в Листинг 9.44
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy	# Листинг 9.46 ... доступ к действию destroy только админам

  def index	# :index добавлено в Листинг 9.21
    @users = User.all   # Листинг 9.23; заменнено в Листинг 9.34
    @users = User.paginate(page: params[:page]) # Листинг 9.34. Пагинация пользователей в index действии
  end

  def show
    @user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])     # Not the final implemention!
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Добро пожаловать на сайт 'Образование'!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id]) # удалено в Листинг 9.14., т.к.появился другой механизм
  end

  def update
    # @user = User.find(params[:id])    # удалено в Листинг 9.14., т.к.появился другой механизм
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end

    # Before filters
#Листинг 10.24. Перемещение метода signed_in_user в Sessions хелпер
#    def signed_in_user
#      unless signed_in?
#        store_location  # добавлено в Листинг 9.18. Добавление store_location в предфильтр :signed_in_user.
#        redirect_to signin_url, notice: "Please sign in."
#      end
#    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user	# добавлено Листинг 9.46
      redirect_to(root_url) unless current_user.admin?
    end
end
