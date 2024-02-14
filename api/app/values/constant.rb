class Constant
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  ITEM_TYPES = {
    consume_item: 'ConsumeItem',
    weapon_item: 'WeaponItem'
  }.freeze
end
