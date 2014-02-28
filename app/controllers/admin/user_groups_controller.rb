class Admin::UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]
  #after_action :rebuild_permission_hash, only: [:create, :destroy]

  # GET /user_groups
  # GET /user_groups.json
  def index
    #@user_groups = UserGroup.all
    if current_user.user_class_id == 1
      @trees = UserGroup.get_trees
    else
      @trees = [UserGroup.get_tree2(UserGroup.last.user_group)]#[UserGroup.get_tree2(current_user.user_group)]
    end
    # if current_user.admin?
    #   @user_group_id = 0
    # else
    #   @user_group_id = current_user.id
    # end
    #@tree = UserGroup.get_tree(@user_group_id)
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
  end

  # GET /user_groups/new
  def new
    @user_group = UserGroup.new
  end

  # GET /user_groups/1/edit
  def edit
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    @user_group = UserGroup.new(user_group_params)

    respond_to do |format|
      if @user_group.save
        UserGroupMap.reload
        format.json { render json: @code, status: :ok }
        format.html { redirect_to '/admin#admin/account_control.html', notice: '成功建立新用户组' }
        #format.json { render action: 'show', status: :created, location: @user_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_group.errors, status: :failed }
        #format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    respond_to do |format|
      if @user_group.update(user_group_params)
        format.html { redirect_to @user_group, notice: 'User group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    @user_group.destroy
    UserGroupMap.reload
    respond_to do |format|
      format.html { redirect_to '/admin#admin/account_control.html', notice: '成功删除新用户组' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :parent_id)
    end
end
