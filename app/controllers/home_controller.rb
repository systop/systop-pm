class HomeController < ApplicationController
  before_action :authenticate_user!
include HomeHelper

  def index
  	kv = AdminSetting.where(alias: "exmo").first.value.split "|"
	exmo = Exmo.new(kv[0], kv[1])
	@summ = exmo.get_summ_in_rubles
  end
end
