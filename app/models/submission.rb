class Submission < ActiveRecord::Base
	validates :text, presence: true,
                    length: { minimum: 5 }
    validates :title, presence: true,
                    length: { minimum: 3 }

end
