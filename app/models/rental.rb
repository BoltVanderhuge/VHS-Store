class Rental < ActiveRecord::Base
    belongs_to :client 
    belongs_to :vhs 


    def due_date
        self.created_at + 7.days
    end
    
    def past_due_date
        self.due_date < self.updated_at
    end 

    def self.past_due_date
        self.all.select{|rental| rental.past_due_date}
    end

end