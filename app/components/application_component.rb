class ApplicationComponent < ViewComponent::Base
  use_helpers :signed_in?, :current_user
end
