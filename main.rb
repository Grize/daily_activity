# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'rom'
require 'yaml'
require 'pry'

# Main app class
class App < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
    db_config = YAML.load_file("#{root}/config/database.yml", aliases: true)[settings.environment.to_s]
    db_url = "#{db_config['adapter']}://#{db_config['host']}/#{db_config['database']}"

    ROM.container(:sql, db_url, port: db_config['port'], username: db_config['user'],
                                password: db_config['password']) do |conf|
      conf.register_relation(Relations::Ips)
    end
  end

  get '/' do
    puts 'Hello world!'
  end
end

post 'day' do
  request.body.rewind
  params = JSON.parse(request.body.read)
  record = Services::Days::Create.new(params).call

  redirect to("day/#{record.id}")
end
