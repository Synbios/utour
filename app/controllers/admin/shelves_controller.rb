class Admin::ShelvesController < ApplicationController
	def create
    @shelf = Shelf.new
    @shelf.name = params[:shelf][:name]
    @shelf.rack = params[:shelf][:rack]
    if @shelf.save
      redirect_to '/admin#admin/index_shelf.html'
    else
      redirect_to :back
    end
  end

  def update
    @shelf = Shelf.find_by_id(params[:id])
    unless @shelf.nil?
      @shelf.name = params[:shelf][:name]
    	@shelf.rack = params[:shelf][:rack]

      if @shelf.save
        redirect_to '/admin#admin/shelf_tour.html'
      else
        redirect_to :back
      end
    end
  end

  def destroy
    @shelf = Shelf.find_by_id(params[:id])
    @shelf.destroy
    redirect_to "/admin#admin/index_shelf.html"
  end
end
