class ScheduledPhotosController < ApplicationController
  # GET /scheduled_photos
  # GET /scheduled_photos.xml
  def index
    @scheduled_photos = ScheduledPhoto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scheduled_photos }
    end
  end

  # GET /scheduled_photos/1
  # GET /scheduled_photos/1.xml
  def show
    @scheduled_photo = ScheduledPhoto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scheduled_photo }
    end
  end

  # GET /scheduled_photos/new
  # GET /scheduled_photos/new.xml
  def new
    @scheduled_photo = ScheduledPhoto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scheduled_photo }
    end
  end

  # GET /scheduled_photos/1/edit
  def edit
    @scheduled_photo = ScheduledPhoto.find(params[:id])
  end

  # POST /scheduled_photos
  # POST /scheduled_photos.xml
  def create
    @scheduled_photo = ScheduledPhoto.new(params[:scheduled_photo])

    respond_to do |format|
      if @scheduled_photo.save
        format.html { redirect_to(@scheduled_photo, :notice => 'ScheduledPhoto was successfully created.') }
        format.xml  { render :xml => @scheduled_photo, :status => :created, :location => @scheduled_photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scheduled_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scheduled_photos/1
  # PUT /scheduled_photos/1.xml
  def update
    @scheduled_photo = ScheduledPhoto.find(params[:id])

    respond_to do |format|
      if @scheduled_photo.update_attributes(params[:scheduled_photo])
        format.html { redirect_to(@scheduled_photo, :notice => 'ScheduledPhoto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scheduled_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduled_photos/1
  # DELETE /scheduled_photos/1.xml
  def destroy
    @scheduled_photo = ScheduledPhoto.find(params[:id])
    @scheduled_photo.destroy

    respond_to do |format|
      format.html { redirect_to(scheduled_photos_url) }
      format.xml  { head :ok }
    end
  end
end
