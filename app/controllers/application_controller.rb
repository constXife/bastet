# Application Controller
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # default action
  def home
    render text: '', layout: true
  end

  def test
    ActionCable.server.broadcast 'sensors',
                                 message: 'test'
    render :nothing => ''
  end
end
