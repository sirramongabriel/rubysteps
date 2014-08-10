class MathsController < ApplicationController
  def add
    sum = params[:num1].to_i + params[:num2].to_i
    render text: sum
  end

  def subtract
    difference = params[:num1].to_i - params[:num2].to_i
    render text: difference
  end
end
