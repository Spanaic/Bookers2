class ApplicationController < ActionController::Base

    # アプリケーションコントローラは、全体のアクションを司るコントローラ
    # デバイス用のコントローラが存在しないため、ここに記述することで制御していく

    before_action :configure_permitted_parameters, if:  :devise_controller?

    before_action :authenticate_user!, except: [:about,:new]

    # before_actionは全てのアクションを行う前にやりましょう！とアクションするもの
    # authenticate_user!はログイン認証されていないユーザを指す
    # except:は[]に書いているアクション（ページ）以外は許可しません！
    # only:は[]のアクション（ページ）しか許可しません！ということ

    # 未ログインのユーザーがアクセスできるページはexcept:で許可してあげなくてはいけない。
    # 許可しないとあafter_sign_out_path_forを記述しても、デフォルトのリダイレクト先に飛んでしまう

    # except: [:new ]　<=　記述するのは間違っていなかった
    # ログイン画面へのリダイレクトなら onlyオプションを使用しなくてもオッケ
    # except:オプションをしようすれば、ログインしていない人ができるアクションを指定することも！

    def after_sign_in_path_for(resource)
        user_path(resource)
    end
    # 上記の記述はrubyの書き方
    # メソッド（引数）を書くと、メソッド内で記述するという基本的なルールがある
    # 引数自体に何かを呼び出したり代入したりする機能はなく、このメソッドが実行される前の段階でresourceという引数に（current_user.id）という変数が渡されている。

    def after_sign_up_path_for(resource)
        user_path(resource)
    end

    def before_sign_out_path_for(resource)
        new_user_path(resource)
    end

    def after_sign_out_path_for(resource)
        root_path(resource)
    end

    # deviseへのアクションはアプリケーションコントローラに記述する
    # ログイン後はサインアップとログイン画面にアクセスすると”/”にリダイレクトされるように設定されている

    # deviseの認証情報を変更する（メールアドレスから名前、など）場合は必要な手順が３つある
    # 1.configを変更する
    # 2.form_forを変更すること
    # 3.ストロングパラメータを設定すること

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
            # name情報をform_forに通すため、他のコントローラからでも呼び出せるストロングパラメータを設定している
    end
end
