module API
  module V1
    class Comments < Grape::API
      helpers do
        # Strong Parametersの設定
        def comment_params
          ActionController::Parameters.new(params).permit(:invite_id)
        end

        def create_params
          ActionController::Parameters.new(params).permit(:text, :invite_id)
        end

        def update_params
          ActionController::Parameters.new(params).permit(:text, :invite_id).merge(user_id: current_user.id)
        end

        def set_comment
          @comment = Comment.find(params[:id])
        end

        # パラメータのチェック
        params :create do
          requires :text, type: String, desc: "Comment text."
          requires :invite_id, type: Integer, desc: "Comment invite_id."
        end

        params :update do
          requires :text, type: String, desc: "Comment text."
          requires :invite_id, type: Integer, desc: "Comment invite_id."
        end

        params :id do
          requires :id, type: Integer, desc: "Comment id."
        end
      end

      resource :comments do
        desc 'GET /api/v1/comments'
        get '', jbuilder: 'api/v1/comments/index' do
          invite = Invite.find(comment_params)
          @comments = invite.comments if invite.comments.present?
        end

        desc 'POST /api/v1/comments/create'
        params do
          use :create
        end
        post '/create', jbuilder: 'api/v1/comments/create' do
          comment = current_user.comments.create(create_params)
          unless comment.save
            @error_message = comment.error.full_messages
            return
          end
          user = Invite.find(comment.invite_id).user
          user.notifications.create(content: "#{comment.user.name} #{comment.text}") unless user.id == current_user.id
        end

        desc 'GET /api/v1/comments/:id'
        params do
          use :id
        end
        get '/:id', jbuilder: 'api/v1/comments/show' do
          set_comment
        end

        desc 'PUT /api/v1/comments/:id'
        params do
          use :id
          use :update
        end
        put '/:id' do
          set_comment
          @comment.update(update_params)
        end

        desc 'DELETE /api/v1/comments/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_comment
          @comment.destroy
        end
      end
    end
  end
end
