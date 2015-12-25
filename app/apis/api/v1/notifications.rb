module API
  module V1
    class Notifications < Grape::API
      helpers do
        # Strong Parametersの設定


        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Notification id."
        end
      end

      resource :notifications do
        desc 'GET /api/v1/notifications'
        get '', jbuilder: 'api/v1/notifications/index' do
          @notifications = Notification.timeline_notifications(current_user)
        end
      end
    end
  end
end
