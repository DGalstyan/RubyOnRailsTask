class CreateForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t|
      t.string   :data
      t.string   :name
      t.string   :country_code
      t.string   :lat
      t.string   :lng
      t.string   :time_zone_offset
      t.string   :time_zone_name
      t.boolean  :default_forecast
      t.integer  :city_id, null: true
      t.timestamps
    end
  end
end
