class LifeController < ApplicationController
    before_action :login_required
    def index
     @mes = "" 
    end
end
