class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if:  :devise_controller?

    before_action :authenticate_user!, except: [:about]
    # except: [:new ]
    # ログイン画面へのリダイレクトなら onlyオプションを使用しなくてもオッケ
    # except:オプションをしようすれば、ログインしていない人ができるアクションを指定することも！

    def after_sign_in_path_for(resource)
        user_path(resource)
    end

    def after_sign_up_path_for(resource)
        user_path(resource)
    end

    def before_sign_out_path_for(resource)
        new_user_path
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
