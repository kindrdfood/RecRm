class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  respond_to :html
  before_filter :load_post, only: [:edit, :update]
  
  def index
    @posts = Monologue::Post.all.includes_users
    @authors = Monologue::User.order(:email)
    @tags_grouped = Monologue::Tag.grouped_tags
    @tags = Monologue::Tag.all
  end

  def new
    @authors = Monologue::User.order(:email)
    @post = Monologue::Post.new
  end

  # Preview a post without saving.
  def preview
    # mockup our models for preview.
    @post = Monologue::Post.new post_params
    @post.user_id = monologue_current_user.id
    @post.published_at = Time.zone.now
    @showcase_tags = Monologue::Tag.showcase_tags
    # render it exactly as it would display when live.
    render "/monologue/posts/show", layout: Monologue::Config.layout || "/layouts/monologue/application"
  end

  def create
    find_or_create_tags
    @authors = Monologue::User.order(:email)
    @post = Monologue::Post.new post_params
    @post.user_id = monologue_current_user.id
    if @post.save
      prepare_flash_and_redirect_to_edit()
    else
      render :new
    end
  end

  def edit
    @authors = Monologue::User.order(:email)
  end

  def update
    
    find_or_create_tags 

    @authors = Monologue::User.order(:email)
    if @post.update(post_params)
  
      prepare_flash_and_redirect_to_edit()
    else
      render :edit
    end
  end

  def destroy
    post = Monologue::Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, notice:  I18n.t("monologue.admin.posts.delete.removed")
    else
      redirect_to admin_posts_path, alert: I18n.t("monologue.admin.posts.delete.failed")
    end
  end

private

  # used for form
  def find_or_create_tags
    tag_key = Monologue::Post.tag_key
    tag_key.each do |param_name, category_name|
      if params[:post][param_name]
        tags_array = params[:post][param_name].split(",")
        tags_array.each do |tag_name|
          tag = Monologue::Tag.find_or_create_by(name: tag_name, tag_category: category_name)

          if params[:post][:tag_list]
            params[:post][:tag_list] += "," + tag.name
          else
            params[:post][:tag_list] = tag.name
          end
        end
      end
      params[:post].delete param_name
    end
  end

  def load_post
    @post = Monologue::Post.find(params[:id])
  end

  def prepare_flash_and_redirect_to_edit
    if @post.published_in_future? && ActionController::Base.perform_caching
      flash[:warning] = I18n.t("monologue.admin.posts.#{params[:action]}.saved_with_future_date_and_cache")
    else
      flash[:notice] =  I18n.t("monologue.admin.posts.#{params[:action]}.saved")
    end
    redirect_to edit_admin_post_path(@post)
  end

  def post_params
    params.require(:post).permit(:published, :tag_list,:title,:content,:url,:published_at, :target_published_at, :author_id, :content_type, :public, :tag_ids => [])
  end
end
 