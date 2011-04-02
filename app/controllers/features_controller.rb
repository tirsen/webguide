class FeaturesController < ApplicationController
  # GET /features
  # GET /features.xml
  def index
    zoom = params[:zoom]
    minlat = params[:minlat]
    maxlat = params[:maxlat]
    minlng = params[:minlng]
    maxlng = params[:maxlng]
    raise 'Need zoom' unless zoom

    @features = Feature.
        limit(128).
        order('score DESC').
        where('first_zoom_level <= ? AND (lat BETWEEN ? AND ?) AND (lng BETWEEN ? AND ?)',
              zoom.to_i, minlat.to_f, maxlat.to_f, minlng.to_f, maxlng.to_f)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @features }
      format.json  { render :json => @features }
    end
  end

  # GET /features/1
  # GET /features/1.xml
  def show
    @feature = Feature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feature }
    end
  end

  # GET /features/new
  # GET /features/new.xml
  def new
    @feature = Feature.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feature }
    end
  end

  # GET /features/1/edit
  def edit
    @feature = Feature.find(params[:id])
  end

  # POST /features
  # POST /features.xml
  def create
    @feature = Feature.new(params[:feature])

    respond_to do |format|
      if @feature.save
        format.html { redirect_to(@feature, :notice => 'Feature was successfully created.') }
        format.xml  { render :xml => @feature, :status => :created, :location => @feature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /features/1
  # PUT /features/1.xml
  def update
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to(@feature, :notice => 'Feature was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.xml
  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy

    respond_to do |format|
      format.html { redirect_to(features_url) }
      format.xml  { head :ok }
    end
  end
end
