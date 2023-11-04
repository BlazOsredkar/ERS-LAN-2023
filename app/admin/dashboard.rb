# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do


    panel "Uporabnikov status" do
      user_status_counts = User.group(:user_status_id).count
      data = UserStatus.all.map { |status| [status.name, (user_status_counts[status.id] || 0).to_i] }
      pie_chart data, suffix: ' users'
    end


  end # content
end
