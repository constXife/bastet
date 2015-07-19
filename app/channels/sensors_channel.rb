class SensorsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'sensors'
  end
end
