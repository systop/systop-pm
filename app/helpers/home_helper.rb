require 'net/https'
require 'uri'
require 'json'
module HomeHelper

class Exmo

	def initialize(key,secret)
		@KEY = key
		@SECRET = secret
	end

	def request(method, params = nil)
		params = {} if params.nil?
		nonce = Time.now.strftime("%s%6N")
		params['nonce'] = nonce
		uri = URI.parse(['https://api.exmo.com/v1', method].join('/'))
		post_data = URI.encode_www_form(params)
		digest = OpenSSL::Digest.new('sha512')
		sign = OpenSSL::HMAC.hexdigest(digest, @SECRET, post_data)
		headers = {'Sign' => sign, 'Key'  => @KEY}
		http = Net::HTTP.new(uri.host, uri.port)
		req = Net::HTTP::Post.new(uri.path, headers)
		req.body = post_data
		http.use_ssl = true if uri.scheme == 'https'
		response = http.request(req)
		JSON.load response.body.to_s
	end

	def summ
		
	end
end

















end
