# app/controllers/discord_notifications_controller.rb
class DiscordNotificationsController < ApplicationController
  before_action :authenticate_admin_user!
  def send_notification
    content = params[:content] # You can retrieve the notification content from the request
    role = params[:role] # You can retrieve the notification content from the request

    if content.blank? || role.blank?
      redirect_to discord_send_path, alert: 'Vnesi vse podatke.'
      return
    end

    bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

    # Replace 'CHANNEL_ID' with your Discord channel ID where you want to send the message
    channel = bot.channel(ENV['BOT_CHANNEL_ID'])

    #check if the user is admin
    if current_user.admin?
      # Example of a fancy message using Discord webhook format
      fancy_message = {
        content: '<@&' + role + '>',
        embeds: [
          {
            title: 'Novo obvestilo',
            description: content,
            color: 002074, # Hex color code, you can use any color
            fields: [],
            author: {
              name: 'Avtor obvestila: ' + current_user.username, # Replace with your name
              icon_url: 'https://lanparty.scv.si/assets/poskus_1-89aca5f58d719f324493589859d8218bdf6084392abcdef6d2fc43443fea3bd2.png' # Replace with your author image URL
            }
          }
        ]
      }

      # Example of sending the fancy message using webhook (replace 'WEBHOOK_URL' with your actual webhook URL)
      require 'rest-client'
      RestClient.post(ENV['SERVER_WEBHOOK'], fancy_message.to_json, content_type: :json)

      render plain: 'Notification sent to Discord!'
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
