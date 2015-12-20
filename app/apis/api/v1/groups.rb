module API
  module V1
    class Groups < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:name, :password, :password_confirmation)
        end

        def login_params
          ActionController::Parameters.new(params).permit(:name, :password)
        end

        def set_message_board
          @message_board = MessageBoard.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須(requires)、任意(optional)を指定することができる。
        # use :attributesという形で使うことができる。
        params :attributes do
          requires :name, type: String, desc: "Group name."
          requires :password, type: String, desc: "Group password"
          requires :password_confirmation, type: String, desc: "Group password_confirmation"
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Group id."
        end
      end

      resource :groups do
        desc 'GET /api/v1/groups'
        get '', jbuilder: 'api/v1/groups/index' do
          @user = current_user
        end

        desc 'POST /api/v1/groups'
        params do
          use :attributes
        end
        post '', jbuilder: 'api/v1/groups/create' do
          @group = Group.new(create_params)
          @error_message = @group.error.full_messages unless @user.save
        end

        desc 'GET /api/v1/groups/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/groups/show' do
          set_message_board
        end

        desc 'PUT /api/v1/groups/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_message_board
          @message_board.update(message_board_params)
        end

        desc 'DELETE /api/v1/groups/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_message_board
          @message_board.destroy
        end

        desc 'POST /api/v1/groups/report'
        post '/report', jbuilder: 'api/v1/groups/report' do
          @violation = Violation.new(violation_params)
          unless @violation.save
            @error_message = @letter.errors.full_messages
          end
        end
      end
    end
  end
end
