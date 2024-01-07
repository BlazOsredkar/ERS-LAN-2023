class HomeController < ApplicationController

  def stream
    #check if STREAM_ACTIVE is set to true
    if ENV['STREAM_ACTIVE'] == 'YES'
      render 'home/stream'
    else
      redirect_to root_path, alert: 'Stream trenutno ni na voljo.'
    end
  end
end
