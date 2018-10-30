class SessionsController < ApplicationController

  def new
    if current_user.present?
      user = current_user
      @user_repo_info = user.get_repo_data
      # not having commits
      # @user_commits_info = user.get_commit_data
    end
  end

  def create
  	user = User.from_omniauth(env["omniauth.auth"])

    if user.valid?
      session[:user_id] = user.id
      redirect_to request.env['omniauth.origin']
    end
  end

  def destroy
    reset_session
    redirect_to request.referer
  end
  
end
