class AddCountryAndCityToUsers < ActiveRecord::Migration
  def change
		add_column :users, :location_country, :string
		add_column :users, :location_city, :string
  end
end
