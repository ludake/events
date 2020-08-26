class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token,:only => [ :update ] 
  before_action :authenticate, :except => [ :index, :show]
  
  respond_to  :html, :xml, :json 
  
  def observe_new
      session[:event_draft] = current_user.events.build(params[:event])
      render:nothing => true
  end

  def event_params
    params.require(:event).permit(:name, :tag_list) ## Rails strong params usage
  end

  # GET /events
  # GET /events.xml
  def index
    params.permit!
    @events = Event.paginate :page => params[:page], :per_page => 4
    respond_with(@events)
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    params.permit!
    @event = Event.find(params[:id])
    respond_with(@event)
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = current_user.events.build
    respond_with(@event)
  end

  # GET /events/1/edit
  def edit
    params.permit!
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    params.permit!
    @event = current_user.events.build(params[:event])
    @event.categories << Category.find(params[:categories]) unless params[:categories].blank?
    @event.tag_list.add(params[:tags]) if params[:tags]

    respond_to do |format|
      if @event.save
        flash[:notice] = t('Event was successfully created')
        session[:event_draft] = nil
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    params.permit!
    begin 
      @event = current_user.events.find(params[:id])
      @event.attributes = params[:event]
      @event.category_ids = params[:categories]
      @event.tag_list.add(params[:tags]) if params[:tags]
      @event.image_url=parmas[:image_url] if params[:image_url]
      respond_to do |format|
        if @event.update_attributes(params[:event])
           format.html { redirect_to @event, notice: I18n.t('Event was successfully updated') }
           format.json { head :no_content }
        else
           format.html { render action: "edit" }
           format.json { render json: @event.errors, status:  :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      @event = nil
 
    end
     
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    params.permit!
    Event.find(params[:id]).destroy
    
    respond_to do |format|
        format.html { redirect_to(events_url) }
        format.xml  { head :ok }
    end
  end
end
