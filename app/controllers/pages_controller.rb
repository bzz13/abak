class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to @page, :notice => "Successfully created page."
    else
      render :action => 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to @page, :notice  => "Successfully updated page."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_url, :notice => "Successfully destroyed page."
  end

  # show existing root by name
  # or create new with name
  def root
    @rootName = params[:root]
    @pages = Page.roots.select{|root| root.name == @rootName}
    if @pages.length == 0
      @page = Page.new
      @page.name = @rootName
      render :action => 'new'
    else
      @page = @pages[0]
      render :action => 'show'
    end
  end 

  # edit existing root by name
  # or create new with name
  def newRoot
    @rootName = params[:root]
    @pages = Page.roots.select{|root| root.name == @rootName}
    if @pages.length == 0
      @page = Page.new
      @page.name = @rootName
      render :action => 'new'
    else
      @page = @pages[0]
      render :action => 'edit'
    end
  end

  # show existing child by name
  # or create new with name
  def child
    @rootName = params[:root]
    @pages = Page.roots.select{|root| root.name == @rootName}
    unless @pages.length == 0
      @page = findTreeNamedNode(params[:children].split('/'), @pages[0])
      unless @page.nil?
        render :action => 'show'
      else
        @pages = Page.all
        render :action => 'index'
      end
    else
      @pages = Page.all
      render :action => 'index'
    end
  end
 
  # edit existing root by name
  # or create new with name
  def newChild
    @rootName = params[:root]
    @pages = Page.roots.select{|root| root.name == @rootName}
    unless @pages.length == 0
      @children = params[:children].split('/')
      @page = findTreeNamedNode(@children, @pages[0])
      if @page.nil? # if not yet exists
        @children = params[:children].split('/')
        @ansNames = @children.first(@children.length - 1)
        @ans = findTreeNamedNode(@ansNames, @pages[0])
        if @ans.nil? # if we haven't part of full path for creatng node
          render :action => 'index'
        else
          @page = @ans.children.create("name" => @children.last())
          render :action => 'new'
        end
      else         # if already exists
        render :action => 'edit'
      end
    else
      render :action => 'index'
    end
  end
end
