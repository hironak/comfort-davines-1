class CreateConsumerInformation < ActiveRecord::Migration
  def change
    create_table :consumer_information do |t|
      t.references :consumer, index: true
      t.string   "family_name"
      t.string   "given_name"
      t.string   "family_name_kana"
      t.string   "given_name_kana"
      t.string   "postalcode"
      t.string   "prefecture_code"
      t.string   "address"
      t.string   "building"
      t.string   "phone"

      t.timestamps
    end
  end
end
