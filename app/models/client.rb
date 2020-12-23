class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhs, through: :rentals 

    def cost_rentals
       cost_of_rentals = self.rentals.count 
       (cost_of_rentals * 5.35) 
       cost_of_rentals
    end 

    #if current = false 
    # and updated_at - created_at > 4
    #+= $12  

    def self.paid_most
    binding.pry    
    self.all.max_by{|client| client.cost_rentals}
    end 
    
end

# - `Client.paid_most` - returns an instance who has spent most money at the store; one rental is $5,35 upfront (bonus: additional $12 charge for every late return — do not count those that have not yet been returned) 