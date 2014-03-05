class ChangeColumnOnPressRelease < ActiveRecord::Migration
  def change
    change_column :press_releases, :corner, :text
  end
end
