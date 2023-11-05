class FormsController < ApplicationController
  def submit_form
    # ... your form handling logic ...

    # Check if the user clicked the button in the banner
    if params[:anketa_submitted] == 'true'
      # Set a cookie to prevent displaying the banner again
      cookies[:anketa_banner_closed] = {
        value: 'true',
        expires: 1.year.from_now,
        httponly: true
      }
    end

    redirect_back fallback_location: root_path


    # ... your response logic ...
  end
end
