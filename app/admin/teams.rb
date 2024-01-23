ActiveAdmin.register Team do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :code, :user_id, :is_verified, :image_verified, :avatar, :game_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :code, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #fix the issue regarding Ransack needs ActiveStorage::Attachment attributes explicitly allowlisted as searchable

  filter :avatar_attachment, as: :string



  remove_filter :is_verified
  remove_filter :image_verified
  remove_filter :avatar_attachment

  controller do
    def update
      @team = Team.find(params[:id])
      if @team.update(permitted_params[:team])
        # Add logic to trigger Discord notification if is_verified changes to true
        if @team.saved_change_to_is_verified?(from: false, to: true)
          notification_content = "Ekipa **#{@team.name}** je bila potrjena za dogodek!"
          send_discord_notification(notification_content)
        end
        redirect_to admin_team_path(@team)
      else
        render :edit
      end
    end

    private

    def send_discord_notification(content)
      bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']
      channel = bot.channel(ENV['BOT_CHANNEL_ID'])
      fancy_message = {
        embeds: [
          {
            title: 'Nova ekipa je bila potrjena!',
            description: content,
            color: 002074, # Hex color code, you can use any color
            fields: [],
            author: {
              name: 'lanparty.scv.si', # Replace with your name
              icon_url: 'https://cdn-icons-png.flaticon.com/512/4158/4158206.png'
            }
          }

        ]
      }
      require 'rest-client'
      RestClient.post(ENV['SERVER_WEBHOOK'], fancy_message.to_json, content_type: :json)


    end
  end


  #create remove_from_team_admin_team_path
  member_action :remove_from_team, method: :delete do
    team = Team.find(params[:id])
    user = User.find(params[:user_id])
    team.users.delete(user)
    redirect_to admin_team_path(team), notice: 'Uporabnik je uspešno odstranjen iz ekipe.'
  end



  index do
    selectable_column
      id_column
      column "Ime", :name
      column "Koda", :code
      column "Lastnik", :user
      column "Je potrjena", :is_verified
      column "Je ekipa polna", :is_full do |team|
        if team.users.count+1 == team.game.number_of_players
          status_tag "YES"
        else
          status_tag "NO"
        end
      end
      column "Število članov", :users do |team|
        "#{(team.users.count + 1)} / #{team.game.number_of_players}"
      end
      column "Izbrana igra", :game
      column "Slika potrjena", :image_verified

    actions
  end

  show do
    attributes_table do
      row :name
      row :code
      row :user
      row :users do |team|
        table_for team.users.order('username ASC') do
          column "Včlanjeni" do |user|
            user.username
          end
          column "Ime in priimek" do |user|
            user.name + " " + user.surname
          end
          column "Vrži iz ekipe" do |user|
            link_to "Vrži", remove_from_team_admin_team_path(team, user_id: user.id), method: :delete, data: { confirm: 'Ali si prepričan?' }
          end
        end
      end
      row :avatar do |team|
        if team.avatar.attached?
          image_tag url_for(team.avatar), width: 200
        else
          "Ni slike"
        end
      end
    end
  end

end
