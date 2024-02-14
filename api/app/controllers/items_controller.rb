class ItemsController < ApplicationController
  def add
    user = User.find(params[:user_id])
    item_type = params[:item_type]
    item_id = params[:item_id]

    # アイテムの紐づけ
    item = user.add_item(item_type, item_id)

    if item && item.itemable_id == user.id
      render json: { message: 'Item added successfully', item: item }, status: :ok
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def lottery
    treasure_box = TreasureBox.find(params[:treasure_box_id])

    # 抽選ロジック
    items = treasure_box.lottery_items

    render json: items
  end
end
