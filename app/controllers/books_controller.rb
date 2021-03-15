class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(book.id)
    else
      @book = book
      @books = Book.all
      render 'index'
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(book)
    else
      @book = book
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
