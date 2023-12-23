# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do


    panel "Uporabnikov status" do
      user_status_counts = User.group(:user_status_id).count
      data = UserStatus.all.map { |status| [status.name, (user_status_counts[status.id] || 0).to_i] }
      pie_chart data, suffix: ' users'
    end

    #show the number of selected games of teams (the number of teams that have selected the game, we have a many to many relationship with teams and games)

    panel "Izbrane igre" do
      game_counts = Game.left_outer_joins(:teams).group(:name).count
      data = Game.all.map { |game| [game.name, (game_counts[game.name] || 0).to_i] }
      pie_chart data, suffix: ' teams'
    end


    panel "Status opreme" do
    # Count the number of users with and without equipment
    users_with_equipment = User.where(has_equipment: true).count
    users_without_equipment = User.where(has_equipment: false).count

    # Prepare data for the pie chart
    data = [['Ima opremo', users_with_equipment], ['Nima opreme', users_without_equipment]]

    # Render the pie chart
    pie_chart data, suffix: ' users'
  end






  end # content
end
