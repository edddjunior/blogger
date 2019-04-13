class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]
  before_action :authenticate_user!, :except => [:show]

  def show
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to post_path(@comment.post)
      flash.now[:notice] = "Comentário Incluído Com Sucesso!"
    else
      redirect_to post_path(@comment.post)
      flash.now[:error] = "Oh oh :/ Falha Ao Incluir Comentário!"
    end
  end

  def destroy
    post = @comment.post #or Post.find(params[:post_id]) 
    #post = @comment.post or post = Post.find(params[:post_id])   
    if @comment.destroy
      redirect_to post_path(post)
      flash.now[:notice] = "Comentário Excluído Com Sucesso!"
    else
      redirect_to post_path(post)
      flash.now[:error] = "Oh oh :/ Falha Ao Excluir Comentário!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    delegate :user_id, :to => :user

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
end
