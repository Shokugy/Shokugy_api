module API
  module V1
    class Reviews < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:review, :rate, :restaurant_id)
        end

        def update_params
          ActionController::Parameters.new(params).permit(:review, :rate, :restaurant_id).merge(user_id: current_user.id)
        end

        def set_review
          @review = Review.find(params[:id])
        end

        # パラメータのチェック
        params :attributes do
          requires :review, type: String, desc: "Review review."
          requires :rate, type: Float, desc: "Review rate."
          requires :restaurant_id, type: Integer, desc: "Review restaurant_id."
        end

        params :id do
          requires :id, type: Integer, desc: "Review id."
        end
      end

      resource :reviews do
        desc 'GET /api/v1/reviews'
        get '/', jbuilder: 'api/v1/reviews/index' do
          @reviews = Review.where(id: 1300..1303)
        end

        desc 'GET /api/v1/reviews/mypage'
        get '/mypage', jbuilder: 'api/v1/reviews/mypage' do
          @reviews = current_user.reviews.order("created_at DESC") if current_user.reviews.present?
        end

        desc 'POST /api/v1/reviews/create'
        params do
          use :attributes
        end
        post '/create', jbuilder: 'api/v1/reviews/create' do
          review = current_user.reviews.create(create_params)
          unless review.save
            @error_message = review.error.full_messages
            return
          end
        end

        desc 'GET /api/v1/reviews/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/reviews/show' do
          set_review
        end

        desc 'PUT /api/v1/reviews/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_review
          @review.update(update_params)
        end

        desc 'DELETE /api/v1/reviews/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_review
          @review.destroy
        end
      end
    end
  end
end
