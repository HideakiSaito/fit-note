class MaintenanceController < ApplicationController
  before_action :login_required
  def index
   @mes = "" 
  end
  def pages_delete_all
   l = Line.delete_all #子供のテーブルから消す
   pi = PageImage.delete_all #子供のテーブルから消す
   se = PageSelfy.delete_all #子供のテーブルから消す
   p = Page.delete_all
   @mes = "pages => #{p}  page_image => #{pi} & page_sely => #{se} & lines =>#{l} delete_all" 
   render :index
  end
  def items_delete_all
   i = Item.delete_all
   @mes = "items => #{i} delete_all" 
   render :index
  end
  def foods_delete_all
   i = Food.delete_all
   @mes = "foods => #{i} delete_all" 
   render :index
  end
  def pages_import
   @mes = "import1" 
   Page.import(params[:pages_file]) # fileはtmpに自動で一時保存される
   Line.import(params[:lines_file])
   p = Page.all.size
   l = Line.all.size
   @mes = "pages => #{p} & lines =>#{l}  import" 
   render :index
  end
  def items_import
   Item.import(params[:file])
   i = Item.all.size
   @mes = "items => #{i} import" 
   render :index
  end
  def foods_import
   Food.import(params[:file])
   i = Food.all.size
   @mes = "foods => #{i} import" 
   render :index
  end
end
