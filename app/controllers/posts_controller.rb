class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:redirect]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]

	impressionist actions: [:redirect]#, unique: [:session_hash]
	require 'net/http'
	
	def index
		if user_signed_in?
			find_posts
		else
		end
	end
	
	def show

	end
	
	def new
		find_posts
		@post = current_user.posts.build
	end

	def create
		#todo
	 	@post = current_user.posts.build(post_params)
 		@post.statistics << Statistic.create(clicks: 0,ref: "direct")
		find_posts
		if @post.link =~ /https?:\/\/steemit.com/
			if @post.save
				redirect_to root_path
			else
				render 'new'
			end
		else
		end
	end

	def edit
	end

	def update

		if post_steem_params[:steem].to_i > current_user.steem
			flash[:error] = "Your book was not found"
		elsif post_steem_params[:payout].to_i > post_steem_params[:steem].to_i

		else		
			if @post.update(post_steem_params)
				redirect_to root_path
			else 
				render edit ''
			end
		end
		'''
		respond_to do |format|
			if @post.update(post_steem_params)
	      		format.html { redirect_to(root_path, notice: "Success") }
	      		format.json { render json: root_path, status: :created, location: @post }
	    	else
	      		format.html { redirect_to(post_path(@post.id), alert: "to sort it out."") }
	       		# format.html { render action: "new" }
	       		format.json { render json: @post.errors, status: :unprocessable_entity }
	    	end
	    end
	    '''
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	def use
		@post = Post.find(params[:id])
		@post.upvote_by current_user
		redirect_to :back
	end
	def unuse
		@post = Post.find(params[:id])
		@post.downvote_by current_user
		redirect_to :back
	end

	def random
		@post = Post.find(Random.rand(1..Post.count)) #
		send_file "public" + @post.image.url[0..-12] , type: 'image/png', disposition: 'inline'
		File.open('test.txt', 'w') do |f|
			f.puts "Referrer: "+ request.referer
		end
		p "Post link: "+ @post.link
		p "Params: "+ params[:user]
		p "Referrer: "+ request.referer
		p "Image URL: "+@post.image.url
	end

	def redirect
		@post = Post.find(params[:id])
		redirect_to @post.link
	end

	private

	def find_post
		@post = current_user.posts.find(params[:id])
	end
	def find_posts
		@posts = current_user.posts.all.order("created_at DESC")
	end
	def post_params
		params.require(:post).permit(:title,:category_id, :link, :image)
	end
	def post_steem_params
		params.require(:post).permit(:id,:steem,:payout)
	end
end
