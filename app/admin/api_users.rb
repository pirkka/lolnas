ActiveAdmin.register Api::User do
  controller.authorize_resource(:class => "Api::User")

  menu :label => "Api users"
end
