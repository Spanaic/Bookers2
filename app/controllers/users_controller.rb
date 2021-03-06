class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @book = Book.new
        @books = @user.books.all
        # 変数に定義して特定したユーザのレコードに関連づいたレコードを別のモデルから探し出して、全て@booksに代入する
    end

    def new
    end

    def edit
        @user = User.find(params[:id])
        if current_user.id == @user.id
            # redirect_to edit_user_path(@user.id)
            # localhost でリダイレクトが繰り返し行われました。のエラーで無限ループに。素直にリダイレクトをさせなければユーザのeditページに飛ぶ
        else
            redirect_to user_path(current_user.id)
        end
    end

    def index
        @users = User.all
        @book = Book.new
    end

    def update
        @user = User.find(params[:id])
        if  @user.update(user_params)
            flash[:notice] = "You have updated user successfully."
            redirect_to user_path(@user.id)
        else
            render :edit
        end
    end

    def about
    end

    private
    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
