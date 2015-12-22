module API
  module V1
    class Invites < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:text, :restaurant_id)
        end

        def set_invite
          @invite = Invite.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :create do
          # requires :review, type: String, desc: "Review review."
          # requires :rate, type: Float, desc: "Review rate."
          # requires :restaurant_id, type: Integer, desc: "Review restaurant_id"
          # requires :user_id, type: Integer, desc: "Review user_id"
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Invite id."
        end
      end

      resource :invites do
        desc 'GET /api/v1/invites'
        get '/', jbuilder: 'api/v1/invites/index' do
          @invites = Invite.where(id: 1300..1303)
        end

        desc 'POST /api/v1/invites/create'
        params do
          use :create
        end
        post '', jbuilder: 'api/v1/invites/create' do
          invite = Invite.new(create_params)
          @error_message = invite.error.full_messages unless invite.save
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