class BookCommentsController < ApplicationController
  before_action :ensure_correct_book_comment, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @new_book_comment = BookComment.new
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    unless comment.save
      render "error"
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
  end

   private

      def book_comment_params
        params.require(:book_comment).permit(:comment)
      end

      def ensure_correct_book_comment
        book = Book.find(params[:book_id])
        unless book.user == current_user
        redirect_to books_path
      end

  end

end