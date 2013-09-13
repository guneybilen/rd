class UsersController < ApplicationController
  before_filter :signed_in_user,
                only:[:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only:[:edit, :update]
  before_filter :admin_user, only: :destroy

  def users_search_autocomplete
       keyword = params[:q]
       h = Array.new
       if (keyword.length > 1)
         @users = User.search(keyword)
         @users.each do |user|
           @users = h << ({:id => user.name, #this value goes into search_text parameter that is needed in search method in this class
                           :name => user.name})
         end

#      @users = @users.sort_by { |k| k[:name] }

       respond_to do |format|
           format.js
           format.json { render json: @users }  #autocomplete icin format.json { render json: @jobs} gerekiyor
         end
       end
  end




  def search

      if params[:search_text].blank?
        @to_users = true
        index
        render 'users/index' and return
      end

      @users = User.search(params[:search_text])
      @users = @users.paginate(page: params[:page])
      render 'users/index'
  end


  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def index
    @users = User.paginate(page: params[:page])
    if defined?(params[:to_users])
      @to_users = true
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user? @user
  end

  def update
    # @user = User.find(params[:id])
    # correct_user before filter took care of: @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    # @user = User.find(params[:id])
    # correct_user before filter took care of: @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the ReferansData!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    if signed_in?
      @user = User.find(params[:id])
      @posts = @user.posts.paginate(page: params[:page])
    else
      redirect_to signin_path
    end
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
