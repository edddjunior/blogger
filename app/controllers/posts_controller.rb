class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comment.post_id = @post.id  
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = "Post '#{@post.title}' criado com sucesso!"
    else
      render :new
      flash.now[:error] = "Oh oh :/ Falha ao incluir post!"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash.now[:notice] = "Post '#{@post.title}' atualizado com sucesso!"
    else
      render :new
      flash.now[:error] = "Oh oh :/ Falha ao atualizar post!"
    end
  end

  def destroy
   if @post.destroy 
      redirect_to root_path
      flash.now[:notice] = "Post excluído com sucesso!"
    else
      redirect_to show_post_path    
      flash.now[:error] = "Oh oh :/ Falha ao excluir post!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    delegate :user_id, :to => :user

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :image)
    end
end
