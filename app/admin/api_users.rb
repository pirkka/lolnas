ActiveAdmin.register Api::User do
  controller.authorize_resource

  menu :label => "Api users"
end
