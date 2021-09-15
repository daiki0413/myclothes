class CategoriesController < ApplicationController
    before_action:authenticate_user

    def show
        # categoryテーブルのid
        # Tagの名前を表示するために @categoryTagを定義
        @categoryTag = Category.find(params["id"])
        # ClothモデルからTagごとに写真を呼び出す
        # Tagごとの写真を表示するために @itemsを定義
        @items = Cloth.where(category_item_id:params["id"])
    end
end
