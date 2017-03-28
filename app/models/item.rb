class Item < ApplicationRecord

  validates :name, presence: true

  validates :todo, presence: true

  belongs_to :todo, inverse_of: :items

end
