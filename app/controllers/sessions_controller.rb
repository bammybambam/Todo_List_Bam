class SessionsController < ApplicationController
def create
  auth = request.env["omniauth.auth"]

  session[:id_token] = auth.dig("credentials", "id_token") || auth.dig("extra", "id_token")

  @user = User.find_or_create_by(uid: auth["uid"]) do |u|
    u.email = auth.info.email
    u.first_name = auth.info.first_name
    u.last_name = auth.info.last_name
  end

  if @user.persisted?
    session[:uid] = auth["uid"]
    puts "SESSION #{session[:uid]}"

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
