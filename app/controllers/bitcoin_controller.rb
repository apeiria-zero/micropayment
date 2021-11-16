require 'bitcoin'
require 'net/http'
require 'json'
Bitcoin.chain_params = :regtest
HOST="localhost"
PORT=38332
RPCUSER="hoge" 
RPCPASSWORD="hoge"
class BitcoinController < ApplicationController
   before_action :list, only: [:index]
   before_action :create, only: [:index]

   def list
        @utxos=bitcoinRPC('listunspent',[])
        @amount=(@utxos[0]["amount"]).to_f
   end
   
   def bitcoinRPC(method, params)
    http = Net::HTTP.new(HOST, PORT)
    request = Net::HTTP::Post.new('/')
    request.basic_auth(RPCUSER, RPCPASSWORD)
    request.content_type = 'application/json'
    request.body = { method: method, params: params, id: 'jsonrpc' }.to_json
    JSON.parse(http.request(request).body)["result"]
    end
    def index
    end

    def create
     txid = bitcoinRPC('sendtoaddress',[params[:to_address],params[:amount]])
     if txid
          flash[:notice] = '送金に成功しました'
          redirect_to root_path
     end
    end
end