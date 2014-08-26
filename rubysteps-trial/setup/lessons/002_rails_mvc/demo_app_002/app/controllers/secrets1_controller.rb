class Secrets1Controller < ApplicationController
  def show
    message = {
      "jay" => "hey brother",
      "bj" => "how's the baby?",
      "mom" => "I love you! I'll call you later"
    }[params[:id]]

    render text: message
  end
end
