ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :name, :surname, :has_equipment, :username, :user_status_id, :confirmed_at, :unconfirmed_email, :isadmin
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :name, :surname, :has_equipment, :username, :user_status_id, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :isadmin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #

  index do
    selectable_column
    id_column
    column "e-pošta", :email
    column "Uporabniško ime", :username
    column "Ime", :name
    column "Priimek", :surname
    column "Ima opremo", :has_equipment
    column "Status", :user_status
    column "Admin", :isadmin
    column "Mail potrjen", :confirmed_at
    actions
  end


  #dont show other things on edit
  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :name
      f.input :surname
      f.input :user_status
      f.input :has_equipment
      f.input :isadmin
    end
    f.actions

  end


  collection_action :send_email_view, method: :get do
  end

  collection_action :send_email, method: :post do
    subject = params[:subject]
    body = params[:body]
    @users = User.all.where(isadmin: false)
    @users.each do |user|
      UserMailer.send_email_to_user(user, subject, body).deliver_later
    end
    redirect_to admin_users_path, notice: "Mail je bil uspešno poslan!"
  end




  #create an action that sends email to all users
  action_item :send_email, only: :index do
    link_to 'Pošlji mail vsem', send_email_view_admin_users_path
  end

end
