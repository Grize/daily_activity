# frozen_string_literal: true

# Class for day record creation
class Services::Days::Create
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    Day.create(params)
  end
end
