class Intranet::PostsController < Intranet::IntranetController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /posts
  # GET /posts.json

  def index

    if params[:kind_of_post_id]
      @posts = Post.all.where('kind_of_post_id' => params[:kind_of_post_id]).order(id: :desc)
    else
      @posts = Post.all.order(id: :desc)
    end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.galleries.build
    @kind = params[:kind]
    @data = Time.now.strftime('%Y-%m-%d')
  end

  # GET /posts/1/edit
  def edit
    @post = Post.friendly.find(params[:id])
    @post.galleries.build
    @kind = params[:kind]
  end

  # POST /posts
  # POST /posts.json
  def create
    @kind = params[:kind]
    @post = Post.new(post_params)
    if params[:foto_principal]
      data =  params[:foto_principal]
      image_data = Base64.decode64(data['data:image/png;foto_principal,'.length .. -1])
      File.open("#{Rails.root}/public#{@post.foto_principal.url.to_s}", 'wb') do |f|
        f.write image_data
      end
      # // Carierwave method to regenerate thumbnails
      @post.image.recreate_versions!
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to intranet_kind_of_post_posts_path(@post.kind_of_post_id), notice: 'Criado com sucesso.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    @post.remover_foto_principal(params[:remover_foto_principal])
    @post.remover_foto(params[:remover_foto])
    @post = Post.friendly.find(params[:id])
    @kind = params[:kind]
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to intranet_kind_of_post_posts_path(@post.kind_of_post_id), notice: 'Atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to intranet_kind_of_post_posts_path(@post.kind_of_post_id), notice: 'Deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def seleciona(tipopostname)
    Post.all.where(kind_of_post_id.name + ' LIKE ?', "%#{tipopostname}%")
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:titulo, :subtitulo, :descricao, :data, :inativar, :keywords, :kind_of_post_id, :category_id, :category_ativo_inativo, :foto_principal, :foto, :galleries_attributes => [:image, :id, :_destroy, :position ])
  end
end
