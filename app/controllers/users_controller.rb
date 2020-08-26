class UsersController < ApplicationController
 #skip_before_action :verify_authenticity_token,:only => [:create, :update] 
  before_action :authenticate, :only => [:edit, :update]
  respond_to  :html, :xml, :json 
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end
  
  def new
    @user = User.new
    respond_with(@user)
  end
  
  def create
    params.permit!
    @user = User.new(params[:user])
    
    respond_to do |format|
      if request.post? and @user.save
        flash.now[:notice] = I18n.t('Dear') + @user.login + ',' + I18n.t('Thanks for signing up!')
        session[:user_id] = @user.id
        format.html { redirect_to events_url }
        format.xml  { render :xml => events_url, :status => :created, :location => events_url }
        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        
      end
    end
    
  end
    
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    respond_to do |format|
      if request.post? and current_user.update_attributes(params)
        flash.now[:notice] = t('Information updated')
        format.html { redirect_to :action => 'show', :id => current_user.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        
      end
    end
  end
  
  def login
    params.permit!
    if request.post?
        if user = User.authenticate(params[:login],params[:password])
          session[:user_id] = user.id
          redirect_to events_url 
        else
          flash[:notice] = t('Invalid login/password combination')
        end
    end
  end
  
  def logout
    session[:user_id] = nil
    
    respond_to do |format|
      format.html { redirect_to :root  }
      format.xml  { head :ok }
    end
  end
  
end
