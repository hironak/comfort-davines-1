module Administration
  class SolutionsController < BaseController
    before_action :set_solution, only: [:show, :edit, :update, :destroy]

    # GET /administration/solutions
    # GET /administration/solutions.json
    def index
      @solutions = Solution.all
    end

    # GET /administration/solutions/1
    # GET /administration/solutions/1.json
    def show
    end

    # GET /administration/solutions/new
    def new
      @solution = Solution.new
    end

    # GET /administration/solutions/1/edit
    def edit
    end

    # POST /administration/solutions
    # POST /administration/solutions.json
    def create
      @solution = Solution.new(solution_params)

      respond_to do |format|
        if @solution.save
          format.html { redirect_to [:admin, @solution], notice: 'Solution was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @solution] }
        else
          format.html { render action: 'new' }
          format.json { render json: @solution.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/solutions/1
    # PATCH/PUT /administration/solutions/1.json
    def update
      respond_to do |format|
        if @solution.update(solution_params)
          format.html { redirect_to [:admin, @solution], notice: 'Solution was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @solution.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/solutions/1
    # DELETE /administration/solutions/1.json
    def destroy
      @solution.destroy
      respond_to do |format|
        format.html { redirect_to admin_solutions_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:name)
    end
  end
end
