class HatebuEidsController < ApplicationController
  # GET /hatebu_eids
  # GET /hatebu_eids.json
  def index
    @hatebu_eids = HatebuEid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hatebu_eids }
    end
  end

  # GET /hatebu_eids/1
  # GET /hatebu_eids/1.json
  def show
    @hatebu_eid = HatebuEid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hatebu_eid }
    end
  end

  # GET /hatebu_eids/new
  # GET /hatebu_eids/new.json
  def new
    @hatebu_eid = HatebuEid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hatebu_eid }
    end
  end

  # GET /hatebu_eids/1/edit
  def edit
    @hatebu_eid = HatebuEid.find(params[:id])
  end

  # POST /hatebu_eids
  # POST /hatebu_eids.json
  def create
    @hatebu_eid = HatebuEid.new(params[:hatebu_eid])

    respond_to do |format|
      if @hatebu_eid.save
        format.html { redirect_to @hatebu_eid, notice: 'Hatebu eid was successfully created.' }
        format.json { render json: @hatebu_eid, status: :created, location: @hatebu_eid }
      else
        format.html { render action: "new" }
        format.json { render json: @hatebu_eid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hatebu_eids/1
  # PUT /hatebu_eids/1.json
  def update
    @hatebu_eid = HatebuEid.find(params[:id])

    respond_to do |format|
      if @hatebu_eid.update_attributes(params[:hatebu_eid])
        format.html { redirect_to @hatebu_eid, notice: 'Hatebu eid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hatebu_eid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hatebu_eids/1
  # DELETE /hatebu_eids/1.json
  def destroy
    @hatebu_eid = HatebuEid.find(params[:id])
    @hatebu_eid.destroy

    respond_to do |format|
      format.html { redirect_to hatebu_eids_url }
      format.json { head :no_content }
    end
  end
end
