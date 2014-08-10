class Calculator
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def add(number)
    @value += number
  end

  def subtract(number)
    @value -= number
  end
end

class Maths5Controller < ApplicationController
  def show
    calculator = Calculator.new(params[:num1].to_i)
    calculator.send(params[:op], params[:num2].to_i) if params[:op]

    add_url = view_context.link_to "+", op: :add, num1: calculator.value, num2: 1
    subtract_url = view_context.link_to "-", op: :subtract, num1: calculator.value, num2: 1

    render text: [subtract_url, calculator.value, add_url].join(" ")
  end
end
