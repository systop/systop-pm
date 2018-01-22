require 'net/https'
require 'uri'
require 'json'

module HomeHelper

	class Exmo

		def initialize(key,secret)
			@KEY = key
			@SECRET = secret
		end

		def request(method, params = {})
			nonce = Time.now.strftime("%s%6N")
			params['nonce'] = nonce

			uri = URI.parse(['https://api.exmo.com/v1', method].join('/'))
			post_data = URI.encode_www_form(params)

			digest = OpenSSL::Digest.new('sha512')
			sign = OpenSSL::HMAC.hexdigest(digest, @SECRET, post_data)
			headers = {'Sign' => sign, 'Key'  => @KEY}

			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true if uri.scheme == 'https'

			req = Net::HTTP::Post.new(uri.path, headers)
			req.body = post_data

			response = http.request(req)
			JSON.load response.body.to_s
		end

		def get_summ_in_rubles
			user_info = request("user_info")
			ticker = request('ticker')
			yandex_rub = 0.0
			user_info["balances"].each do |key,val|
				unless val == "0" || key == "RUB"
					price = ticker["#{key}_RUB"]["avg"]
					summ = val.to_f * price.to_f # summ in rubles
					summ -= summ*0.002 # summ in rubles after exchange
					yandex_rub += summ
				end
			end
			yandex_rub += user_info["balances"]["RUB"].to_f
			yandex_rub -= yandex_rub*0.03 # RUBLES after withdraw
		end

	end
# end

















end
