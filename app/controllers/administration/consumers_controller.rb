module Administration
  class ConsumersController < BaseController
    before_action :set_consumer, only: [:show, :edit, :update, :destroy]

    # GET /administration/consumers
    # GET /administration/consumers.json
    def index
      @q = Consumer.search(params[:q])
      @consumers = @q.result(distinct: true).page(params[:page]).per(20)
    end

    # GET /administration/consumers/1
    # GET /administration/consumers/1.json
    def show
    end

    # GET /administration/consumers/new
    def new
      @consumer = Consumer.new
    end

    # GET /administration/consumers/1/edit
    def edit
    end

    # POST /administration/consumers
    # POST /administration/consumers.json
    def create
      @consumer = Consumer.new(consumer_params)

      respond_to do |format|
        if @consumer.save
          format.html { redirect_to [:admin, @consumer], notice: 'Consumer was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @consumer] }
        else
          format.html { render action: 'new' }
          format.json { render json: @consumer.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/consumers/1
    # PATCH/PUT /administration/consumers/1.json
    def update
      respond_to do |format|
        if @consumer.update(consumer_params)
          format.html { redirect_to [:admin, @consumer], notice: 'Consumer was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @consumer.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/consumers/1
    # DELETE /administration/consumers/1.json
    def destroy
      @consumer.destroy
      respond_to do |format|
        format.html { redirect_to admin_consumers_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      @consumer = Consumer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params[:consumer]
    end
  end
end
