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

  	# This method saves recording as .wav file in audio_data folder and saves recording as binary in Rails database
  	def update
		puts "#{params}"
		id = params["id"].to_i
		@submission = Submission.find(id)
		audio = (params["audio_file"] == "" || params["audio_file"].nil?) ? params["audio"] : params["audio_file"]
		audio = audio.read

		data = ActionController::Parameters.new(audiouser: params["user"], recording: audio)
		if @submission.update(data.permit(:audiouser, :recording))
			
			##Saves files to audio_data folder
			filename = params["id"] + "_" + @submission.title.gsub(" ", "_") + "_" + params["user"].gsub(" ", "_")  # filename = id_title_user
			save_path = Rails.root.join("audio_data/#{filename}.wav")
			redirect_to edit_submission_path(@submission) if audio.nil? 	
		    # Open and write the file to file system.
			File.open(save_path, 'wb') do |f|
				f.write audio
			end
			##
			render :json => {
				:message => "Recording successfully saved!"
			}
		else
			render :json => {
				:message => "ERROR: recording failed"
			}
			redirect_to edit_submission_path(@submission)
		end
	end

	def download_audio
		@submission = Submission.find(params[:id])
    	send_file Rails.root.join("audio_data/#{@submission.id}_#{@submission.title.gsub(" ", "_")}_#{@submission.audiouser.gsub(" ", "_")}.wav"), :type=>"application/wav" 
  	end

	def destroy
	  @submission = Submission.find(params[:id])
	  @submission.destroy
	  user = @submission.audiouser.nil? ? "" : @submission.audiouser
	  path_to_file = Rails.root.join("audio_data/#{@submission.id}_#{@submission.title.gsub(" ", "_")}_#{user.gsub(" ", "_")}.wav")
	  puts "Deleting #{path_to_file}" if File.exist?(path_to_file)
	  File.delete(path_to_file) if File.exist?(path_to_file)
	  redirect_to submissions_path
	end
 
private
  def submission_params
    params.require(:submission).permit(:title, :text, :recording, :textuser, :audiouser)
  end





end
