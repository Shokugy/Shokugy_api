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

        def favorite_params
          ActionController::Parameters.new(params).permit(:restaurant_id)
        end

        def set_restaurant
          @restaurant = Restaurant.find(params[:id])
        end

        # パラメータのチェック
        params :search do
          requires :name, type: String, desc: "Restaurant name."
        end

        params :id do
          requires :id, type: Integer, desc: "Restaurant id."
        end
      end

      resource :restaurants do
        desc 'GET /api/v1/restaurants'
        get '', jbuilder: 'api/v1/restaurants/index' do
          @restaurants = Restaurant.where(id: 1300..1303)
        end

        desc 'GET /api/v1/restaurants/ranking'
        get '/ranking', jbuilder: 'api/v1/restaurants/ranking' do
          ranking_rates = Rate.high_rates(current_user)
          @ranking = []
          if ranking_rates.present?
            ranking_rates.each do |rate|
              @ranking << rate.restaurant
            end
          end
        end

        desc 'GET /api/v1/restaurants/favorite'
        get '/favorite', jbuilder: 'api/v1/restaurants/favorite' do
          @favorites = []
          favorites = current_user.favorites.order("created_at DESC")
          favorites.each do |favorite|
            @favorites << Restaurant.find(favorite.restaurant_id)
          end
        end

        desc 'POST /api/v1/restaurants/search'
        params do
          use :search
        end
        post '/search', jbuilder: 'api/v1/restaurants/search' do
          name = search_params[:name]
          @restaurants = Restaurant.search_restaurants
          Restaurant.set_geocode(@restaurants)
        end

        desc 'POST /api/v1/restaurants/favorite'
        params do
          use :id
        end
        post '/favorite', jbuilder: 'api/v1/restaurants/favorite' do
          current_user.favorites.create(favorite_params)
        end

        desc 'GET /api/v1/restaurants/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/restaurants/show' do
          set_restaurant
        end

      end
    end
  end
end
