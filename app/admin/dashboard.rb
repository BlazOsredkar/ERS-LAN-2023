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
      game_counts = Game.joins(:teams).group(:id).count
      data = Game.all.map { |game| [game.name, (game_counts[game.id] || 0).to_i] }
      pie_chart data, suffix: ' ekipe'
    end





  end # content
end
