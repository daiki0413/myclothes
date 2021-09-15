class UsersController < ApplicationController
    before_action:forbit_login_user,{only:["signup","create","login","login_form"]}

    def signup
        @user=User.create
    end
    def create
        @user=User.create(name:params["user"]["name"],password:params["user"]["password"])
        if @user.save
        session["user_id"]=@user.id
        flash[:notice] = "登録が完了しました"
         redirect_to "/"
        else
         render("users/signup")
        end
    end
    def login_form
    end
    def login
        @user=User.find_by(name:params["user"]["name"],password:params["user"]["password"])
        if @user
         session["user_id"]=@user.id
         flash[:notice] = "ログインしました"
         redirect_to "/"
        else
         @error_message="メールまたはパスワードが間違っています。アカウントをお持ちでない方は新規登録をしてください。"
         render("users/login_form")
        end
    end
    def logout
         session["user_id"]=nil
         flash[:notice] = "ログアウトしました"
         redirect_to "/login"
    end
end
