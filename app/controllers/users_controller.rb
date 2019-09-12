class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
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
    end

    def update
        @user = User.find(params[:id])
        if  @user.update(user_params)
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
