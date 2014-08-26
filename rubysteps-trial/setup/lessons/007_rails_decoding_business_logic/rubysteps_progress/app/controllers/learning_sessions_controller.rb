class LearningSessionsController < ApplicationController
  around_action :restore_and_save_learning_session_state

  def new
  end

  def create
    @learning_session = LearningSession.new # overwrite any restored one
    @learning_session.start

    render action: @learning_session.state
  end

  def update
    if @learning_session.send params[:event]
      render action: @learning_session.state
    else
      render text: "Whoops! Wrong state and event combo"
    end
  end

  def restore_and_save_learning_session_state
    @learning_session = LearningSession.new
    @learning_session.state = session[:learning_session_state] if session[:learning_session_state]

    yield

    session[:learning_session_state] = @learning_session.state
  end
end
