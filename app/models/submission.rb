class Submission < ActiveRecord::Base
	validates :text, presence: true,
                    length: { minimum: 5 }
    validates :title, presence: true,
                    length: { minimum: 3 }


 def recording_to_file
     File.open(:title, "wb") do |f|
       f.write(:recording)
     end
   end


end
