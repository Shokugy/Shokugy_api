module API
  module V1
    class Restaurants < Grape::API
      helpers do
        # Strong Parametersの設定
        def restaurant_params
          ActionController::Parameters.new(params).permit(:title, :body)
        end

        def search_params
          ActionController::Parameters.new(params).permit(:name)
        end

        def set_restaurant
          @restaurant = Restaurant.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :attributes do
          requires :name, type: String, desc: "Restaurant name."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Restaurant id."
        end
      end

      resource :restaurants do
        desc 'GET /api/v1/restaurants'
        get '/', jbuilder: 'api/v1/restaurants/index' do
          @restaurants = Restaurant.where(id: 1300..1303)
        end

        desc 'POST /api/v1/restaurants/search'
        params do
          use :attributes
        end
        post '/search', jbuilder: 'api/v1/restaurants/search' do
          name = search_params[:name]
          @restaurants = Restaurant.where("name LIKE ? OR name_kana LIKE ?", "%#{name}%", "%#{name}%").limit(20)
          Restaurant.set_geocode(@restaurants)
        end

        desc 'GET /api/v1/message_boards/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/message_boards/show' do
          set_message_board
        end

        desc 'PUT /api/v1/message_boards/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_message_board
          @message_board.update(message_board_params)
        end

        desc 'DELETE /api/v1/message_boards/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_message_board
          @message_board.destroy
        end
      end
    end
  end
end
