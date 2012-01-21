module UsersHelper
  
  def gravatar_for user
    gravatar_image_tag user.email, :class => "gravatar", :alt => h(user.name)
  end
  
end
