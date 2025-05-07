# frozen_string_literal: true

require 'sinatra'

get '/' do
  puts 'Hello world!'
end

post 'day' do
  request.body.rewind
  params = JSON.parse(request.body.read)
  record = Services::Days::Create.new(params).call

  redirect to("day/#{record.id}")
end
