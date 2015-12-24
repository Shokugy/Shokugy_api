module API
  module V1
    class Invites < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:text, :restaurant_id, :press_time).merge(group_id: current_user.active_group_id)
        end

        def join_params
          ActionController::Parameters.new(params).permit(:invite_id)
        end

        def set_invite
          @invite = Invite.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :create do
          requires :text, type: String, desc: "Invite text."
          requires :restaurant_id, type: Integer, desc: "Invite restaurant_id."
          optional :press_time, type: DateTime, desc: "Invite press_time."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Invite id."
        end
      end

      resource :invites do
        desc 'GET /api/v1/invites'
        get '', jbuilder: 'api/v1/invites/index' do
          @invites = Invite.where(group_id: current_user.active_group_id).order("created_at DESC")
        end

        desc 'GET /api/v1/invites/mypage'
        get '/mypage', jbuilder: 'api/v1/invites/mypage' do
          @invites = current_user.invites.order("created_at DESC")
        end

        desc 'POST /api/v1/invites/create'
        params do
          use :create
        end
        post '', jbuilder: 'api/v1/invites/create' do
          invite = current_user.invites.new(create_params)
          unless invite.save
            @error_message = invite.error.full_messages
            return
          end
          restaurant = Restaurant.find(invite.restaurant_id)
          group = Group.find(current_user.active_group_id)
          group.users.each do |user|
            user.notifications.create(content: "#{current_user.name}さんが#{restaurant.name}へ一緒に行く仲間を募集しています。") unless user.id == current_user.id
          end
        end

        desc 'POST /api/v1/invites/join'
        params do
          use :id
        end
        post '/join' do
          @invite = Invite.find(join_params)
          @invite.users << current_user
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
          use :create
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
