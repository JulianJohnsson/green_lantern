class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def sendPush
    notif_data = NotificationDatum.find_or_create_by(user_id: current_user.id)
    notif_data.endpoint = params[:subscription][:endpoint]
    notif_data.p256dh_key = params[:subscription][:keys][:p256dh]
    notif_data.auth_key = params[:subscription][:keys][:auth]
    notif_data.save
    sendPayload(current_user)
    render body: nil
  end

  def sendPayload(user)
    @message = get_message(user.name)
    if user.notification_datum.present?
      @notification_data = user.notification_datum
      Webpush.payload_send(endpoint: @notification_data.endpoint,
        message: @message,
        p256dh: @notification_data.p256dh_key,
        auth: @notification_data.auth_key,
        ttl: 24 * 60 * 60,
        vapid: {
          subject: 'contact@hellocarbo.com',
          public_key: Rails.application.credentials[:vapid_public_key],
          private_key: Rails.application.credentials[:vapid_private_key]
        }
      )
      puts "success"
    else
      puts "failed"
    end
  end

  def get_message(name)
    "Hello World"
  end

end
