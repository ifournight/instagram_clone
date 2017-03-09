class FollowActionsController < ApplicationController
  before_action :set_follow_action, only: [:show, :edit, :update, :destroy]

  # GET /follow_actions
  # GET /follow_actions.json
  def index
    @follow_actions = FollowAction.all
  end

  # GET /follow_actions/1
  # GET /follow_actions/1.json
  def show
  end

  # GET /follow_actions/new
  def new
    @follow_action = FollowAction.new
  end

  # GET /follow_actions/1/edit
  def edit
  end

  # POST /follow_actions
  # POST /follow_actions.json
  def create
    @follow_action = FollowAction.new(follow_action_params)

    respond_to do |format|
      if @follow_action.save
        format.html { redirect_to @follow_action, notice: 'Follow action was successfully created.' }
        format.json { render :show, status: :created, location: @follow_action }
      else
        format.html { render :new }
        format.json { render json: @follow_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /follow_actions/1
  # PATCH/PUT /follow_actions/1.json
  def update
    respond_to do |format|
      if @follow_action.update(follow_action_params)
        format.html { redirect_to @follow_action, notice: 'Follow action was successfully updated.' }
        format.json { render :show, status: :ok, location: @follow_action }
      else
        format.html { render :edit }
        format.json { render json: @follow_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follow_actions/1
  # DELETE /follow_actions/1.json
  def destroy
    @follow_action.destroy
    respond_to do |format|
      format.html { redirect_to follow_actions_url, notice: 'Follow action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow_action
      @follow_action = FollowAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follow_action_params
      params.fetch(:follow_action, {})
    end
end
