class JobsController < ApplicationController
  
  ##################
  # Custom Actions #
  ##################

  def indeed_jobs
    @query = params[:query]
    @location = params[:location]

    if @query && @location
      @indeed_jobs = JobSearcher.indeed_search(@query, @location)
    end
  end


  ###################
  # RESTful Actions #
  ###################

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
    # @company = Company.find(params[:company_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    @company = Company.find(@job.company_id)
    @interviews = @job.interviews


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new
    #@company = Company.find(params[:company_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @company = Company.find(@job.company_id)

  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])
    @company = Company.find(params[:job][:company_id])


    respond_to do |format|
      if @job.save
        format.html { redirect_to company_job_path(@company.id, @job.id), notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

end
