get '/' do
  # Look in app/views/index.erb
  @all_posts = Post.all
  erb :index
end


get '/post/:url' do
  @url = params[:url]
  @post = Post.find(@url)
  erb :post
end

get '/comment' do
  @comments = Comment.all
  erb :all_comments
end


get '/comment/:post' do
  @post = Post.find(params[:post])
  @comments = Comment.where(post_id: @post)
  erb :comment
end

post '/comment' do
  @user_input = params[:new_comment]
  @post_id = params[:post_id]
  Comment.create(content: @user_input, user_id: rand(1..100), post_id: @post_id)
  redirect to('/comment/' + @post_id)
end


get '/profile/:user' do
 
 @user = User.find_by_username(params[:user])
 @user_posts = Post.where(user_id: @user.id)
 @user_comments = Comment.where(user_id: @user.id)
 erb :profile
end



get '/login' do
  erb :login
end

get '/logout' do
  session.clear
  redirect to('/')
end


post '/login' do
  @user = User.find_by_username(params[:username])

  if @user
    if @user.authenticate(params[:password])
      session[:valid_user] = params[:username]
      redirect to('/')
    else
      redirect to('/login/:error')
    end
  else
    redirect to('/login/:error')
  end




end
