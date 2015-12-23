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
        params :create do
          requires :name, type: String, desc: "Group name."
          requires :password, type: String, desc: "Group password"
          requires :password_confirmation, type: String, desc: "Group password_confirmation"
        end

        params :login do
          requires :name, type: String, desc: "Group name."
          requires :password, type: String, desc: "Group password."
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
          use :create
        end
        post '/create', jbuilder: 'api/v1/groups/create' do
          # TODO: current_userをgroupに追加
          # user.groups << group
          @group = Group.new(create_params)
          @error_message = @group.error.full_messages unless @user.save
        end

        desc 'POST /api/v1/groups/login'
        params do
          use :login
        end
        post '/login', jbuilder: 'api/v1/groups/login' do
          # TODO: current_userのacrive_group_idをupdate
          # user.update(active_group_id: group.id)
          # user.groupsに存在していなかったら、user.groups << group
          unless @group = login(login_params)
            @error_message = 'login failed'
          end
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
