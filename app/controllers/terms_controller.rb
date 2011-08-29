class TermsController < ApplicationController
  # GET /terms
  # GET /terms.xml
  def index
    @terms = Term.order("name").all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @terms }
    end
  end

  # GET /terms/1
  # GET /terms/1.xml
  def show
#    @term = Term.find(params[:id])
    @term = Term.where(:name=>params[:name]).first

		if not @term
			format.html { redirect_to(@term, :notice => 'Term does not exist yet.') }
		end

    @entries = @term.entries
    logger.debug "entries #{@entries}"
    @entries.each do |entry|
      logger.debug "entry.id  #{entry.id}"
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @term }
    end
  end


	def showbyname
    @term = Term.where(:name=>params[:name]).first

		if not @term
			format.html { redirect_to(@term, :notice => 'Term does not exist yet.') }
		end

    @entries = @term.entries
    logger.debug "entries #{@entries}"
    @entries.each do |entry|
      logger.debug "entry.id  #{entry.id}"
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @term }
    end
	end

  # GET /terms/new
  # GET /terms/new.xml
  def new
    @term = Term.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @term = Term.find(params[:id])
  end

  # POST /terms
  # POST /terms.xml
  def create
    @term = Term.where(:name=>params[:term])
    if not @term
      @term = Term.new(params[:term])
      if @term.save
        redirect_to(@term, :notice => 'Term was successfully created.')
      else
        render :action => "new"
      end

    else
      logger.debug "term name #{@term.name}"
      redirect_to(@term, :notice=>'Term already exists')
    end
    
  end

  # PUT /terms/1
  # PUT /terms/1.xml
  def update
    @term = Term.find(params[:id])

    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to(@term, :notice => 'Term was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.xml
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to(terms_url) }
      format.xml  { head :ok }
    end
  end
end
