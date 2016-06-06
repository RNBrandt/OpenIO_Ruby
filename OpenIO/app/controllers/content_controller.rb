class ContentController < ApplicationController
#Must Create Object class elsewhere
  def index
    # Show all objects
    @contents = Content.all
  end
  def create
    #crate a new Object
    @content = Content.new(params)
  end

  def show
    # get a specific resource
    @content = Content.find(params[:id])
  end

  def destroy
    # delete content
    @content = Content.find(params[:id])
    @content.destroy
end
