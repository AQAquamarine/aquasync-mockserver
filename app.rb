require 'sinatra'
require 'json'
require_relative 'initializer/mongoid'
require_relative 'spec/hoge'
require_relative 'lib/delta_pack_builder'

get '/deltas/from::ust' do
  content_type :json
  {
      "_id" => "8932-302023-320323-923332",
      "model1" => [
        {
          "deviceToken" => "huga",
          "localTimestamp" => 240661481,
          "isDeleted" => false,
          "gid" => "9EA989A1-B5B6-481E-8D75-23533EC9ABA8"
        },
        {
          "deviceToken" => "huga",
          "localTimestamp" => 240661482,
          "isDeleted" => false,
          "gid" => "9EA989A1-B5B6-4S1E-8D75-23533EC9ABA8"
        },
        {
            "deviceToken" => "huga",
            "localTimestamp" => 220661482,
            "isDeleted" => false,
            "gid" => "9EA989A1-B5B6-481E-8D72-23533EC9ABA8"
        },

        {
            "deviceToken" => "huga",
            "localTimestamp" => 12344,
            "isDeleted" => false,
            "gid" => "9EA989A1-B5B6-481E-8D7A-23533EC9ABA8"
        }
      ]
  }.to_json

  builder = DeltaPackBuilder.new
  builder.push_documents Hoge.all
  builder.json
end

post '/deltas' do
  params.each do |model_name, deltas|
    if model_name == "_id"
      puts "received DeltaPack^#{deltas}"
      next
    end
    deltas.each do |delta|
      puts "save #{delta} in #{model_name}"
    end
  end

  content_type :json
  {result: 200}.to_json
end
