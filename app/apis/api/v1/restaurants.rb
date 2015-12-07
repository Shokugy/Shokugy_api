module API
  module V1
    class Restaurants < Grape::API
      helpers do
        # Strong Parametersの設定
        def restaurant_params
          ActionController::Parameters.new(params).permit(:title, :body)
        end

        def set_restaurant
          @restaurant = Restaurant.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :attributes do
          requires :title, type: String, desc: "MessageBoard title."
          optional :body, type: String, desc: "MessageBoard body."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "MessageBoard id."
        end
      end

      resource :restaurants do
        desc 'GET /api/v1/restaurants'
        get '/', jbuilder: 'api/v1/restaurants/index' do
          @restaurants = Restaurant.where(id: 1300..1303)
        end

        desc 'POST /api/v1/message_boards'
        params do
          use :attributes
        end
        post '/' do
          message_board = MessageBoard.new(message_board_params)
          message_board.save
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
