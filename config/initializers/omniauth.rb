# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "761721814445-qafl73d9a17m7lablj5eg57l03t9oaln.apps.googleusercontent.com",
           "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"

  provider :facebook, "731897741230127", "91b9fd6fe85de11d88d6fd6003dac45a"
end
