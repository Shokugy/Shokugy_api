module API
  module V1
    class Users < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:name, :fb_id)
        end

        def violation_params
          ActionController::Parameters.new(params).permit(:contents, :user_id)
        end

        def set_message_board
          @message_board = MessageBoard.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須(requires)、任意(optional)を指定することができる。
        # use :attributesという形で使うことができる。
        params :create do
          requires :name, type: String, desc: "User name."
          requires :fb_id, type: String, desc: "User fb_id"
        end

        # パラメータのチェック
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
          use :create
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
          set_message_board
        end

        desc 'PUT /api/v1/users/:id'
        params do
          use :id
          use :create
        end
        put '/:id' do
          set_message_board
          @message_board.update(message_board_params)
        end

        desc 'DELETE /api/v1/users/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_message_board
          @message_board.destroy
        end

        desc 'POST /api/v1/users/report'
        post '/report', jbuilder: 'api/v1/users/report' do
          @violation = Violation.new(violation_params)
          unless @violation.save
            @error_message = @letter.errors.full_messages
          end
        end
      end
    end
  end
end
