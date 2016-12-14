class PostsController <  ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
    respond_to do |format|
      format.js{render "new"}
      format.html
    end
  end

  def create
    @user = User.find(params[:user_id])
    p params
    @post = Post.new(title: params[:post][:title], body: params[:post][:body], user_id: @user.id)
    if @post.save
      respond_to do |format|
        format.js{render 'show'}
        format.html {render 'show'}
      end
      # redirect_to user_post_path(@user.id, @post.id)
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
