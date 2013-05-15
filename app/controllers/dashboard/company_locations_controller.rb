class Dashboard::CompanyLocationsController < ApplicationController
  before_filter :admin_login_required

  before_filter :get_company

  respond_to :html, :json

  layout 'dashboard'

  # GET /companies
  # GET /companies.xml
  def index
    @company_locations = @company.company_locations.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @company_locations }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company_location = @company.company_locations.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company_locations }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company_location = @company.company_locations.new

    # if params[:status_id]
    #   @company.status_id = params[:status_id]
    # else
    #   @company.status_id = 1
    # end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company_location = @company.company_locations.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js   {render :action => "edit"}
      format.xml  { render :xml => @contact }
    end
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company_location = @company.new(params[:company_location])

    respond_to do |format|
      if @company_location.save
        flash[:notice] = 'Company Location was successfully created.'
        format.html { redirect_to(dashboard_company_path(@company)) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company_location = @ompany.company_locations.find(params[:id])
    respond_to do |format|
      if @company_location.update_attributes(params[:company_location])
        flash[:notice] = 'Company was successfully updated.'
        format.js   { render :js => 'window.location.reload()' }
        format.html { redirect_to(:action => "index") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company_location = @company.company_locations.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(dashboard_companies_url) }
      format.xml  { head :ok }
    end
  end

  protected
    def get_company
      @company = Company.find(params[:company_id]) if params[:company_id]
    end
end
