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

  filter :email

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
    end
    f.buttons
  end
end
