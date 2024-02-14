class TreasureBox < ApplicationRecord
  belongs_to :item_group

  # 抽選メソッド
  def lottery_items
    lottery_machines = self.item_group.item_group_lottery_machines

    selected_items = []
    lottery_machines.each do |machine|
      next unless rand(0..1.0) <= machine.weight

      # 定数化されたitem_typeから実際のアイテムオブジェクトを取得
      item_class = machine.item_type.constantize
      item = item_class.find_by(id: machine.item_id)

      # アイテムが見つかった場合、アイテム名とidをselected_items配列に追加
      selected_items << { item_name: item.name, item_id: item.id } if item
    end

    selected_items
  end
end
