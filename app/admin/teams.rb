ActiveAdmin.register Team do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :code, :user_id, :is_verified
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :code, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #
  #
  #

  remove_filter :games
  remove_filter :is_verified

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
      column "Igre", :games do |team|
        table_for team.games.order('name ASC') do
          column "Igra" do |game|
            link_to game.name, admin_game_path(game)
          end
        end
      end
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
            link_to user.username, admin_user_path(user)
          end
          column "Ime in priimek" do |user|
            user.name + " " + user.surname
          end
          column "Vrži iz ekipe" do |user|
            link_to "Vrži", remove_from_team_admin_team_path(team, user_id: user.id), method: :delete, data: { confirm: 'Ali si prepričan?' }
          end
        end
      end
    end
  end

end
