module Administration
  class FileStoragesController < BaseController
    authorize_actions_for FileStorage

    before_action :set_file_storage, only: [:show, :edit, :update, :destroy]

    # GET /administration/file_storages
    # GET /administration/file_storages.json
    def index
      @file_storages = FileStorage.all
    end

    # GET /administration/file_storages/1
    # GET /administration/file_storages/1.json
    def show
    end

    # GET /administration/file_storages/new
    def new
      @file_storage = FileStorage.new
    end

    # GET /administration/file_storages/1/edit
    def edit
    end

    # POST /administration/file_storages
    # POST /administration/file_storages.json
    def create
      @file_storage = FileStorage.new(file_storage_params)

      respond_to do |format|
        if @file_storage.save
          format.html { redirect_to [:admin, @file_storage], notice: rmt(:successfully, :created, @file storage) }
          format.json { render action: 'show', status: :created, location: [:admin, @file_storage] }
        else
          format.html { render action: 'new' }
          format.json { render json: @file_storage.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /administration/file_storages/1
    # PATCH/PUT /administration/file_storages/1.json
    def update
      respond_to do |format|
        if @file_storage.update(file_storage_params)
          format.html { redirect_to [:admin, @file_storage], notice: rmt(:successfully, :updated, @file storage) }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @file_storage.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /administration/file_storages/1
    # DELETE /administration/file_storages/1.json
    def destroy
      @file_storage.destroy
      respond_to do |format|
        format.html { redirect_to admin_file_storages_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_storage
      @file_storage = FileStorage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_storage_params
      params.require(:file_storage).permit(:name, :path, :file)
    end
  end
end
