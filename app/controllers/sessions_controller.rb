class SessionsController < ApplicationController
skip_before_action :verify_authenticity_token, only: :create

def create
  auth = request.env["omniauth.auth"]

  id_token      = auth.dig("credentials", "id_token") || auth.dig("extra", "id_token")
  access_token  = auth.dig("credentials", "token")
  refresh_token = auth.dig("credentials", "refresh_token")
  expires_at    = auth.dig("credentials", "expires_at")

  puts "ID TOKEN : #{id_token}"
  puts "ACCESS TOKEN : #{access_token}"
  puts "REFRESH TOKEN : #{refresh_token}"
  puts "EXPIRES AT : #{expires_at}"

  @user = User.find_or_create_by(uid: auth["uid"]) do |u|
    u.email = auth.info.email
    u.first_name = auth.info.name
    u.last_name = auth.info.name
  end

  if @user.persisted?
    session[:user_id]       = @user.id
    session[:id_token]      = id_token
    session[:access_token]  = access_token
    session[:refresh_token] = refresh_token
    session[:expires_at]    = expires_at

    redirect_to "/list", notice: "เข้าสู่ระบบสำเร็จ"
  end
end

def destroy
  id_hint = session[:id_token]

  reset_session

  base_url = "http://localhost:8080/realms/ToDo_List/protocol/openid-connect/logout"

  query_params = {
    id_token_hint: id_hint,
    post_logout_redirect_uri: root_url
  }

  redirect_to "#{base_url}?#{query_params.to_query}", allow_other_host: true
end
end
