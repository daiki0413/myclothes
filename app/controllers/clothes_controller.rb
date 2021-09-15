class ClothesController < ApplicationController
    before_action:authenticate_user

    def index
        @items = Cloth.all.order(created_at: :desc)

        if params[:category_item_id].present?
            @items = @items.get_by_item params[:category_item_id]
        end
        if params[:category_color_id].present?
            @items = @items.get_by_color params[:category_color_id]
        end
        if params[:category_season_id].present?
            @items = @items.get_by_season params[:category_season_id]
        end
        if params[:memo].present?
            @items = @items.get_by_memo params[:memo]
        end
    end
    def new
        # select_tag用 @category達はapplication.controller.rbで定義済
    end
    def create
        @item = Cloth.create(image:"default.jpg", category_item_id:params["item"]["category_item_id"], category_color_id:params["item"]["category_color_id"], category_season_id:params["item"]["category_season_id"], price:params["item"]["price"], date:params["item"]["date"], memo:params["memo"])
        if @item.save
            flash[:notice] = "保存が完了しました"
            redirect_to "/"
        else
            @error_message="※Tag・Color・Seasonを入力してください。Priceは半角数字で入力してください。"
            render("clothes/new")
        end
    end
    def edit
        @item = Cloth.find(params["id"])
        # select_tag用 @category達はapplication.controller.rbで定義済
    end
    def update
        @item = Cloth.find(params["id"])
        @item.category_item_id=params["item"]["category_item_id"]
        @item.category_color_id=params["item"]["category_color_id"]
        @item.category_season_id=params["item"]["category_season_id"]
        @item.price=params["item"]["price"]
        @item.date=params["item"]["date"]
        @item.memo=params["memo"]

        if params["image"]
            @item.image="#{@item.id}.jpg"
            image=params["image"]
            File.binwrite("public/item_images/#{@item.image}",image.read)
        end

        if @item.save
            flash[:notice] = "変更が完了しました"
            redirect_to "/"
        else
            @error_message="※Priceは半角数字で入力してください"
            render("clothes/edit")
        end
    end
    def destroy
        @item = Cloth.find(params["id"])
        @item.destroy
        flash[:notice] = "削除が完了しました"
        redirect_to "/"
    end
    def statistics_tag
        @items_count = Cloth.all.count
        # 総額
        @total_price = Cloth.sum("price")
        # 今月の購入額
        current_month = Time.now.all_month
        @current_month_price = Cloth.where(date:current_month).sum("price")
        # 一か月ごとの購入額(1年分)
        to    = Time.current.at_beginning_of_day
        from  = (to - 1.year)
        @year_prices = Cloth.where(date: from...to).group("date(date)").sum("price")
        # 各tagのカウント用
        @tags = [Cloth.where(category_item_id:2),Cloth.where(category_item_id:3),Cloth.where(category_item_id:4),Cloth.where(category_item_id:5),Cloth.where(category_item_id:6),Cloth.where(category_item_id:7),Cloth.where(category_item_id:8),Cloth.where(category_item_id:9),Cloth.where(category_item_id:10)]
        # 各colorのカウント用
        @colors = [Cloth.where(category_color_id:1),Cloth.where(category_color_id:2),Cloth.where(category_color_id:3),Cloth.where(category_color_id:4),Cloth.where(category_color_id:5),Cloth.where(category_color_id:6),Cloth.where(category_color_id:7),Cloth.where(category_color_id:8),Cloth.where(category_color_id:9),Cloth.where(category_color_id:10),Cloth.where(category_color_id:11),Cloth.where(category_color_id:12),Cloth.where(category_color_id:13)]
        # 各seasonのカウント用
        @seasons = [Cloth.where(category_season_id:6),Cloth.where(category_season_id:7),Cloth.where(category_season_id:8),Cloth.where(category_season_id:9),Cloth.where(category_season_id:10)]
    end
    def statistics_color
        @items_count = Cloth.all.count
        # 総額
        @total_price = Cloth.sum("price")
        # 今月の購入額
        current_month = Time.now.all_month
        @current_month_price = Cloth.where(date:current_month).sum("price")
        # 一か月ごとの購入額(1年分)
        to    = Time.current.at_beginning_of_day
        from  = (to - 1.year)
        @year_prices = Cloth.where(date: from...to).group("date(date)").sum("price")
        # 各tagのカウント用
        @tags = [Cloth.where(category_item_id:2),Cloth.where(category_item_id:3),Cloth.where(category_item_id:4),Cloth.where(category_item_id:5),Cloth.where(category_item_id:6),Cloth.where(category_item_id:7),Cloth.where(category_item_id:8),Cloth.where(category_item_id:9),Cloth.where(category_item_id:10)]
        # 各colorのカウント用
        @colors = [Cloth.where(category_color_id:1),Cloth.where(category_color_id:2),Cloth.where(category_color_id:3),Cloth.where(category_color_id:4),Cloth.where(category_color_id:5),Cloth.where(category_color_id:6),Cloth.where(category_color_id:7),Cloth.where(category_color_id:8),Cloth.where(category_color_id:9),Cloth.where(category_color_id:10),Cloth.where(category_color_id:11),Cloth.where(category_color_id:12),Cloth.where(category_color_id:13)]
        # 各seasonのカウント用
        @seasons = [Cloth.where(category_season_id:6),Cloth.where(category_season_id:7),Cloth.where(category_season_id:8),Cloth.where(category_season_id:9),Cloth.where(category_season_id:10)]
    end
    def statistics_season
        @items_count = Cloth.all.count
        # 総額
        @total_price = Cloth.sum("price")
        # 今月の購入額
        current_month = Time.now.all_month
        @current_month_price = Cloth.where(date:current_month).sum("price")
        # 一か月ごとの購入額(1年分)
        to    = Time.current.at_beginning_of_day
        from  = (to - 1.year)
        @year_prices = Cloth.where(date: from...to).group("date(date)").sum("price")
        # 各tagのカウント用
        @tags = [Cloth.where(category_item_id:2),Cloth.where(category_item_id:3),Cloth.where(category_item_id:4),Cloth.where(category_item_id:5),Cloth.where(category_item_id:6),Cloth.where(category_item_id:7),Cloth.where(category_item_id:8),Cloth.where(category_item_id:9),Cloth.where(category_item_id:10)]
        # 各colorのカウント用
        @colors = [Cloth.where(category_color_id:1),Cloth.where(category_color_id:2),Cloth.where(category_color_id:3),Cloth.where(category_color_id:4),Cloth.where(category_color_id:5),Cloth.where(category_color_id:6),Cloth.where(category_color_id:7),Cloth.where(category_color_id:8),Cloth.where(category_color_id:9),Cloth.where(category_color_id:10),Cloth.where(category_color_id:11),Cloth.where(category_color_id:12),Cloth.where(category_color_id:13)]
        # 各seasonのカウント用
        @seasons = [Cloth.where(category_season_id:6),Cloth.where(category_season_id:7),Cloth.where(category_season_id:8),Cloth.where(category_season_id:9),Cloth.where(category_season_id:10)]
    end
end
