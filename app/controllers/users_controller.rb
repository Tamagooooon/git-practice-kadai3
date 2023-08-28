class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = 'You have created book successfully'
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @users = User.all
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = current_user
    @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @books = @user.books
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :title, :body)
  end

  def correct_user
    @user = User.find(params[:id])
    @book = @user.books
    redirect_to(books_path) unless @user == current_user
  end
end
