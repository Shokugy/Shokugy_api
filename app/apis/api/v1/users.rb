module API
  module V1
    class Users < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:name, :fb_id)
        end

        def update_params
          ActionController::Parameters.new(params).permit(:name, :fb_id)
        end

        def set_user
          @user = User.find(params[:id])
        end

        # パラメータのチェック
        params :attributes do
          requires :name, type: String, desc: "User name."
          requires :fb_id, type: String, desc: "User fb_id"
        end

        params :id do
          requires :id, type: Integer, desc: "User id."
        end
      end

      resource :users do
        desc 'GET /api/v1/users'
        get '', jbuilder: 'api/v1/users/index' do
          @user = current_user
        end

        desc 'POST /api/v1/users'
        params do
          use :attributes
        end
        post '/create', jbuilder: 'api/v1/users/create' do
          @user = User.new(create_params)
          unless @user.save
            @error_message = @user.error.full_messages
          end
        end

        desc 'GET /api/v1/users/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/users/show' do
          set_user
        end

        desc 'PUT /api/v1/users/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_user
          @user.update(update_params)
        end

        desc 'DELETE /api/v1/users/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_user
          @user.destroy
        end

      end
    end
  end
end
