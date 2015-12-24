module API
  module V1
    class Comments < Grape::API
      helpers do
        # Strong Parametersの設定
        def create_params
          ActionController::Parameters.new(params).permit(:text, :invite_id)
        end

        def set_comment
          @comment = Comment.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :create do
          requires :text, type: String, desc: "Comment text."
          requires :invite_id, type: Integer, desc: "Comment invite_id."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Comment id."
        end
      end

      resource :comments do
        desc 'GET /api/v1/comments'
        get '/', jbuilder: 'api/v1/comments/index' do
          @comments = Comment.where(id: 1300..1303)
        end

        desc 'POST /api/v1/comments/create'
        params do
          use :create
        end
        post '/create', jbuilder: 'api/v1/comments/create' do
          comment = current_user.comments.create(create_params)
          unless comment.save
            @error_message = comment.error.full_messages
          end
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
