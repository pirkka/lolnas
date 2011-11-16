ActiveAdmin.register AdminUser do
  controller.authorize_resource

  index do
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    column :updated_at

    default_actions
  end

end
