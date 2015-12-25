module API
  module V1
    class Groups < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:name).merge(password: request.headers["Password"], password_confirmation: request.headers["Password-Confirmation"])
        end

        def login_params
          ActionController::Parameters.new(params).permit(:name).merge(password: request.headers["Password"])
        end

        def update_params
          ActionController::Parameters.new(params).permit(:name).merge(password: request.headers["Password"], password_confirmation: request.headers["Password-Confirmation"])
        end

        def login_group
          @group = login(login_params)
        end

        def set_group
          @group = Group.find(params[:id])
        end

        # パラメータのチェック
        params :attributes do
          requires :name, type: String, desc: "Group name."
        end

        params :id do
          requires :id, type: Integer, desc: "Group id."
        end
      end

      resource :groups do
        desc 'GET /api/v1/groups'
        get '', jbuilder: 'api/v1/groups/index' do
          @groups = current_user.groups
        end

        desc 'POST /api/v1/groups'
        params do
          use :attributes
        end
        post '/create', jbuilder: 'api/v1/groups/create' do
          @group = Group.new(create_params)
          unless @group.save
            @error_message = @group.error.full_messages
            return
          end
          @group.users << current_user
        end

        desc 'POST /api/v1/groups/login'
        params do
          use :attributes
        end
        post '/login', jbuilder: 'api/v1/groups/login' do
          login_group
          unless @group
            @error_message = 'login failed'
            return
          end
          current_user.update(active_group_id: @group.id)
          unless @group.users.ids.include?(current_user.id)
            @group.users.each do |user|
              user.notifications.create(content: "#{current_user.name}さんが#{@group.name}に参加しました。")
            end
            @group.users << current_user
          end
        end

        desc 'GET /api/v1/groups/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/groups/show' do
          set_group
        end

        desc 'PUT /api/v1/groups/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_group
          @group.password_confirmation = update_params[:password_confirmation]
          unless @group.change_password!(update_params[:password])
            @error_message = 'password update failed'
            return
          end
        end

        desc 'DELETE /api/v1/groups/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_group
          @group.destroy
        end
      end
    end
  end
end
