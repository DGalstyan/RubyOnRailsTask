class CreateJoinTableForecastsUsers < ActiveRecord::Migration[5.0]
  def self.up
    create_join_table :forecasts, :users do |t|
      t.index [:forecast_id, :user_id]
      t.index [:user_id, :forecast_id]
    end
  end

  def self.down
    drop_table :forecasts_users
  end
end
