class BooksController < ApplicationController

    before_action :authenticate_user!
    before_action :ensure_current_user, {only: [:edit, :update]}

  def index
     @books = Book.all
     @user = current_user
     @book = Book.new
  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @user = @books.user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
     render 'index'
    end

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
     flash[:notice] = "Book was successfully updated."
     redirect_to book_path(@book)
    else
     @books = Book.all
     render :edit

    end
  end

  def destroy
    @book = Book.find(params[:id])

     if @book.destroy
     flash[:notice] = "Book was successfully destroyed."
     redirect_to books_path
     else
     @books = Book.all
     render :index
     end

  end

  private

  def  ensure_current_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      # if @book.user.id != current_user.id 同じ意味
      redirect_to books_path
    end
  end
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end