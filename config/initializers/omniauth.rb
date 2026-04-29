# config/initializers/omniauth.rb
OmniAuth.config.allowed_request_methods = [ :post ]

Rails.application.config.middleware.use OmniAuth::Builder do
  site_url = Rails.application.credentials.dig(:keycloak, :site_url) || "http://localhost:8080"
  realm = Rails.application.credentials.dig(:keycloak, :realm) || "ToDo_List"

  realm_base = "#{site_url}/realms/#{realm}"

  provider :keycloak_openid,
    Rails.application.credentials.dig(:keycloak, :client_id),
    Rails.application.credentials.dig(:keycloak, :client_secret),
    {
      name: "keycloak",
      scope: "openid profile email",
      strategy_class: OmniAuth::Strategies::KeycloakOpenId,
      client_options: {
        site: site_url,
        realm: realm,
        base_url: "",
        authorize_url: "#{realm_base}/protocol/openid-connect/auth",
        token_url:     "#{realm_base}/protocol/openid-connect/token",
        user_info_url: "#{realm_base}/protocol/openid-connect/userinfo",
        jwks_uri:      "#{realm_base}/protocol/openid-connect/certs"
      },
      id_token_signed_response_alg: "RS256"
    }
end
