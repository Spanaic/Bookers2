class BooksController < ApplicationController
    def index
        # @books = Book.page(params[:page]).reverse_order
        # 上記でうまく行かなければ、シンプルにallに変更
        @books = Book.all
        # @user = Book.find(params[:book_user_id])
        @book = Book.new
    end

    def create
        @books = Book.all
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        # ActionController::UrlGenerationError in BooksController#create
        # カラムが埋まってなかったからidが見つけられなかった。idカラムを埋めたことでsaveができて、idを特定できるようになった
        if  @book.save
            flash[:notice] = "You have creatad book successfully."
        # redirect_to user_path(current_user.id)
        redirect_to book_path(@book.id)
        elsif
            render :index
        else
            render :show
            #　showのrenderだと変数が困る
        end
    end

    def show
        @book = Book.find(params[:id])
        # @user = User.find(params[:id])
    end

    def edit
        # @user = User.find(params[:id])
        # userのeditアクションに記述かな？
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        # book = Book.find(params[:id])
        @book.user_id == current_user.id
        if  @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book.id)
        else
            render :edit
        end
    end

    def destroy
        book = Book.find(params[:id])
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
