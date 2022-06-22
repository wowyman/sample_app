# frozen_string_literal: true

<<<<<<< HEAD
=======
# This class is UsersHelper
>>>>>>> 21891a0f2fefc7f3a69469307f46aa8d03321751
module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for user, options = { size: 80 }
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
