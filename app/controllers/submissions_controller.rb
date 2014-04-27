class SubmissionsController < ApplicationController
http_basic_authenticate_with name: "benetech", password: "admin", only: :destroy


  def index
  	@submissions = Submission.all
  end

	def new
		@submission = Submission.new
	end

	def create
  		@submission = Submission.new(submission_params)
  		
  		if @submission.save and params[:commit] == 'Save Without Recording'
    		redirect_to @submission
    	elsif @submission.save and params[:commit] == 'Record Voiceover'
    		redirect_to edit_submission_path(@submission)
  		else
    		render 'new'
 		end
	end

	def show
		@submission = Submission.find(params[:id])
	end


  	def edit
		@submission = Submission.find(params[:id])
  	end



  	def update
  		
	   @submission = Submission.find(params[:id])
	  
	  @submission.recording = params[:submission][:recording].read
	  if @submission.update(params[:submission].permit(:audiouser))
	    redirect_to @submission
	  else
	    redirect_to edit_submission_path(@submission)
	  end
	end

	def save_file
		render :txt=> 'here'
    	@submission = Submission.find(params[:id])
    	@submission.recording = params[:submission][:recording].read
    	render :txt2=> 'hi'
	end


	def destroy
	  @submission = Submission.find(params[:id])
	  @submission.destroy
	 
	  redirect_to submissions_path
	end
 
private
  def submission_params
    params.require(:submission).permit(:title, :text, :recording, :textuser, :audiouser)
  end





end
