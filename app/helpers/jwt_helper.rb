module JwtHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base
  def encode(account)
    payload = {
      acount_id: account.id,
      created_at: DateTime.now.strftime("%Q")
    }
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
  end
end