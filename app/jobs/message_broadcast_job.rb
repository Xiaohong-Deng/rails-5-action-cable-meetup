class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room-#{params}:messages", message: render_message(message)
  end

  private
    def render_message(message)
      # using render outside of controller is new in rails 5
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end

end
