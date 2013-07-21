class HatebuTagsController < ApplicationController
  # GET /hatebu_tags
  # GET /hatebu_tags.json
  def index
    @hatebu_tags = HatebuTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hatebu_tags }
    end
  end

  # GET /hatebu_tags/1
  # GET /hatebu_tags/1.json
  def show
    @hatebu_tag = HatebuTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hatebu_tag }
    end
  end

  # GET /hatebu_tags/new
  # GET /hatebu_tags/new.json
  def new
    @hatebu_tag = HatebuTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hatebu_tag }
    end
  end

  # GET /hatebu_tags/1/edit
  def edit
    @hatebu_tag = HatebuTag.find(params[:id])
  end

  # POST /hatebu_tags
  # POST /hatebu_tags.json
  def create
    @hatebu_tag = HatebuTag.new(params[:hatebu_tag])

    respond_to do |format|
      if @hatebu_tag.save
        format.html { redirect_to @hatebu_tag, notice: 'Hatebu tag was successfully created.' }
        format.json { render json: @hatebu_tag, status: :created, location: @hatebu_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @hatebu_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hatebu_tags/1
  # PUT /hatebu_tags/1.json
  def update
    @hatebu_tag = HatebuTag.find(params[:id])

    respond_to do |format|
      if @hatebu_tag.update_attributes(params[:hatebu_tag])
        format.html { redirect_to @hatebu_tag, notice: 'Hatebu tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hatebu_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hatebu_tags/1
  # DELETE /hatebu_tags/1.json
  def destroy
    @hatebu_tag = HatebuTag.find(params[:id])
    @hatebu_tag.destroy

    respond_to do |format|
      format.html { redirect_to hatebu_tags_url }
      format.json { head :no_content }
    end
  end
end
