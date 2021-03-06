class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :set_author, only: [:create, :update]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  # GET /collections
  # GET /collections.json
  def index
    @archives = {}
    Collection.all.sort_by(&:latest_story_date).reverse.group_by{|x| x.completed_on.beginning_of_month if x.completed_on}.each do |date, stories|
      @archives[date.strftime('%B %Y')] = stories.count if date
    end
    @collections = Collection.page(params[:page]).per(5).where(type: params[:type])
    @type = params[:type]
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    puts @collection.stories
    @stories = Story.page(params[:page]).per(3).where(in? @collection.stories)
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(@params)
    puts @collection.inspect
    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @collection }
      else
        format.html { render action: 'new' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(@params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

  # When author is passed as user_id, find user and replace in params hash
    def set_author
      user = User.find(collection_params[:author])
      @params = {author: user, title: collection_params[:title], completed: collection_params[:completed], type: collection_params[:type]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:title, :author, :completed, :type)
    end
end
