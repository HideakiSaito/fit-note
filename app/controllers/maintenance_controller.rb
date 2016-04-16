class MaintenanceController < ApplicationController
  def index
   @mes = "" 
  end
  def pages_delete_all
   l = Line.delete_all #子供のテーブルから消す
   p = Page.delete_all
   @mes = "pages => #{p} & lines =>#{l} delete_all" 
   render :index
  end
  def items_delete_all
   i = Item.delete_all
   @mes = "items => #{i} delete_all" 
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
end
