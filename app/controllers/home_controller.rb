class HomeController < ApplicationController
  before_action :authenticate_user!
include HomeHelper

  def index
  	kv = AdminSetting.where(alias: "exmo").first.value.split "|"
	exmo = Exmo.new(kv[0], kv[1])
	user_info = exmo.request("user_info")
	ticker = exmo.request('ticker')
	exmo_rub = 0.0

	user_info["balances"].each do |key,val|
		unless val == "0"
			# puts key + " = " + val
			price = ticker["#{key}_RUB"]["avg"]
			summ = val.to_f * price.to_f
			summ_in_rubles = summ - summ*0.002
			exmo_rub += summ_in_rubles
		end
	end
	@yandex_rub = exmo_rub - exmo_rub*0.03

  end
end
