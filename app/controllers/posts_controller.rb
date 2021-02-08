class PostsController < ApplicationController
    http_basic_authenticate_with name: "Pussycat", password: "", except: [:index, :show]

    def index
        # заводим переменную, в которую с помощью метода класса помещаем все созданные нами посты
        @posts = Post.all
    end
    
    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        # render plain: params[:post].inspect
        @post = Post.new(post_params)

        if(@post.save) 
            redirect_to @post #позволяет переходить сразу после создания страницы-поста на неё
        else
            render 'new'
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        # render plain: params[:post].inspect
        @post = Post.find(params[:id])

        if(@post.update(post_params)) 
            redirect_to @post #позволяет переходить сразу после создания страницы-поста на неё
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to posts_path
    end

    private def post_params
        params.require(:post).permit(:title, :body)
    end
end
