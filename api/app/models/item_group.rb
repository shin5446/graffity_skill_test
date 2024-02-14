class ItemGroup < ApplicationRecord
  has_many :treasure_boxes
  has_many :item_group_lottery_machines
end
