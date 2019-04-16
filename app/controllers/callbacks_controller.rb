class CallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to root_path
      flash.now[:notice] = "SUCESSOOOO!"
    end
  end

  def failure
    redirect_to root_path
    flash.now[:error] = "Oh oh :/ Falha ao se conectar!"
  end
end
