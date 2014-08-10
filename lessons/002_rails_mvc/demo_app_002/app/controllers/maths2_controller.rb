class Maths2Controller < ApplicationController
  def show
    @value ||= 0
    add_url = view_context.link_to "+", action: :add, num1: @value, num2: 1
    subtract_url = view_context.link_to "-", action: :subtract, num1: @value, num2: 1

    render text: [subtract_url, @value, add_url].join(" ")
  end

  def add
    @value = params[:num1].to_i + params[:num2].to_i
    show
  end

  def subtract
    @value = params[:num1].to_i - params[:num2].to_i
    show
  end
end
