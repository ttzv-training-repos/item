class ProgressBarChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "progress_bar_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
