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

class Maths4Controller < ApplicationController
  helper_method :calculator

  def add
    calculator.add params[:num2].to_i
    render action: :show
  end

  def subtract
    calculator.subtract params[:num2].to_i
    render action: :show
  end

  def calculator
    @calculator ||= Calculator.new(params[:num1].to_i)
  end
end
