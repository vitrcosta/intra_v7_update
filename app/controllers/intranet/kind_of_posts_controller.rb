class Intranet::KindOfPostsController < Intranet::IntranetController
  before_action :set_kind_of_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  # GET /kind_of_posts
  # GET /kind_of_posts.json
  def index
    @kind_of_posts = KindOfPost.all
  end

  # GET /kind_of_posts/1
  # GET /kind_of_posts/1.json
  def show
  end

  # GET /kind_of_posts/new
  def new
    @kind_of_post = KindOfPost.new
  end

  # GET /kind_of_posts/1/edit
  def edit
  end

  # POST /kind_of_posts
  # POST /kind_of_posts.json
  def create
    @kind_of_post = KindOfPost.new(kind_of_post_params)

    respond_to do |format|
      if @kind_of_post.save
        format.html { redirect_to intranet_kind_of_posts_url, notice: 'Kind of post was successfully created.' }
        format.json { render :show, status: :created, location: @kind_of_post }
      else
        format.html { render :new }
        format.json { render json: @kind_of_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kind_of_posts/1
  # PATCH/PUT /kind_of_posts/1.json
  def update
    respond_to do |format|
      if @kind_of_post.update(kind_of_post_params)
        format.html { redirect_to intranet_kind_of_posts_url, notice: 'Kind of post was successfully updated.' }
        format.json { render :show, status: :ok, location: @kind_of_post }
      else
        format.html { render :edit }
        format.json { render json: @kind_of_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kind_of_posts/1
  # DELETE /kind_of_posts/1.json
  def destroy
    @kind_of_post.destroy
    respond_to do |format|
      format.html { redirect_to intranet_kind_of_posts_url, notice: 'Kind of post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kind_of_post
      @kind_of_post = KindOfPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kind_of_post_params
      params.require(:kind_of_post).permit(:name)
    end
end
