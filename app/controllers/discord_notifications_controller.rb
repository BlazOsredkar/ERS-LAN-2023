# app/controllers/discord_notifications_controller.rb
class DiscordNotificationsController < ApplicationController
  before_action :authenticate_admin_user!
  def send_notification
    content = params[:content] # You can retrieve the notification content from the request

    bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

    # Replace 'CHANNEL_ID' with your Discord channel ID where you want to send the message
    channel = bot.channel(ENV['BOT_CHANNEL_ID'])

    #check if the user is admin
    if current_user.admin?
      channel.send_message(content)
      bot.run(async = false) # Set async to true for async sending if needed
      redirect_to discord_send_path, notice: 'Obvestilo je bilo uspešno poslano.'
    else
      redirect_to root_path, alert: 'Nimaš dovoljenja za ogled te strani.'
    end
  end

  def new_notification
    # This action renders the view for sending Discord notifications
    # It's optional and depends on whether you want a separate view for the notification form
    render 'send_notification'
  end
end
