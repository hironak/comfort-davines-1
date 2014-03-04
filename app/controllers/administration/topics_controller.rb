class Administration::TopicsController < ApplicationController
  before_action :set_administration_topic, only: [:show, :edit, :update, :destroy]

  # GET /administration/topics
  # GET /administration/topics.json
  def index
    @administration_topics = Administration::Topic.all
  end

  # GET /administration/topics/1
  # GET /administration/topics/1.json
  def show
  end

  # GET /administration/topics/new
  def new
    @administration_topic = Administration::Topic.new
  end

  # GET /administration/topics/1/edit
  def edit
  end

  # POST /administration/topics
  # POST /administration/topics.json
  def create
    @administration_topic = Administration::Topic.new(administration_topic_params)

    respond_to do |format|
      if @administration_topic.save
        format.html { redirect_to @administration_topic, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @administration_topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @administration_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administration/topics/1
  # PATCH/PUT /administration/topics/1.json
  def update
    respond_to do |format|
      if @administration_topic.update(administration_topic_params)
        format.html { redirect_to @administration_topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @administration_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/topics/1
  # DELETE /administration/topics/1.json
  def destroy
    @administration_topic.destroy
    respond_to do |format|
      format.html { redirect_to administration_topics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administration_topic
      @administration_topic = Administration::Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administration_topic_params
      params.require(:administration_topic).permit(:date, :subject, :url)
    end
end
