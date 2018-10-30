opts = { scope: 'user:email' }

Rails.application.config.middleware.use OmniAuth::Builder do
	github_client_id = "40dfda687b126f6397ba"
	github_client_secret = "128e78ab73415c3e2d4f13b2c32ab80d31faa04c"
  provider :github, github_client_id, github_client_secret, opts
end