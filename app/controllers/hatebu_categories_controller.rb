class HatebuCategoriesController < ApplicationController
  # GET /hatebu_categories
  # GET /hatebu_categories.json
  def index
    @hatebu_categories = HatebuCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hatebu_categories }
    end
  end

  # GET /hatebu_categories/1
  # GET /hatebu_categories/1.json
  def show
    @hatebu_category = HatebuCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hatebu_category }
    end
  end

  # GET /hatebu_categories/new
  # GET /hatebu_categories/new.json
  def new
    @hatebu_category = HatebuCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hatebu_category }
    end
  end

  # GET /hatebu_categories/1/edit
  def edit
    @hatebu_category = HatebuCategory.find(params[:id])
  end

  # POST /hatebu_categories
  # POST /hatebu_categories.json
  def create
    @hatebu_category = HatebuCategory.new(params[:hatebu_category])

    respond_to do |format|
      if @hatebu_category.save
        format.html { redirect_to @hatebu_category, notice: 'Hatebu category was successfully created.' }
        format.json { render json: @hatebu_category, status: :created, location: @hatebu_category }
      else
        format.html { render action: "new" }
        format.json { render json: @hatebu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hatebu_categories/1
  # PUT /hatebu_categories/1.json
  def update
    @hatebu_category = HatebuCategory.find(params[:id])

    respond_to do |format|
      if @hatebu_category.update_attributes(params[:hatebu_category])
        format.html { redirect_to @hatebu_category, notice: 'Hatebu category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hatebu_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hatebu_categories/1
  # DELETE /hatebu_categories/1.json
  def destroy
    @hatebu_category = HatebuCategory.find(params[:id])
    @hatebu_category.destroy

    respond_to do |format|
      format.html { redirect_to hatebu_categories_url }
      format.json { head :no_content }
    end
  end
end
