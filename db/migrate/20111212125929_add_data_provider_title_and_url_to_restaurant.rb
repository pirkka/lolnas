class AddDataProviderTitleAndUrlToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :data_provider_title, :string
    add_column :restaurants, :data_provider_url, :string
  end
end
