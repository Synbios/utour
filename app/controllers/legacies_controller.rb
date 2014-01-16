class LegaciesController < ApplicationController
  include LegaciesHelper

  def home
    @node_tag = params[:node]
    @node_tag = "" if @node_tag.nil?
    @current_node = locate_node(JSON.parse(LEGACY), @node_tag)
    
    if @current_node.nil?

    end
    @node_content = @current_node["contents"]
    respond_to do |format|
      format.html { render :layout => "layouts/legacy" }
      format.json { render :json => @current_node }
    end
  end
end
