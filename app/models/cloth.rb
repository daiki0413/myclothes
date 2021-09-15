class Cloth < ApplicationRecord
    belongs_to:category, optional: true
    belongs_to:category_color, optional: true
    belongs_to:category_season, optional: true

    validates:category_item_id,{presence:true}
    validates:category_color_id,{presence:true}
    validates:category_season_id,{presence:true}
    validates:price,{numericality: true, allow_nil: true}

    #メモの部分一致による絞り込み
    scope :get_by_memo, ->(memo) {where("memo like ?", "%#{memo}%")}

    # タグ・カラー・シーズンによる絞り込み
    scope :get_by_item, ->(category_item_id) {where(category_item_id: category_item_id)}
    scope :get_by_color, ->(category_color_id) {where(category_color_id: category_color_id)}
    scope :get_by_season, ->(category_season_id) {where(category_season_id: category_season_id)}
end
