class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhs, through: :rentals 

    def cost_rentals
       cost_of_rentals = (self.rentals.count).to_f
       (cost_of_rentals *= 5.35) 
       cost_of_rentals += self.late_fees
    end 

    def late_fees
        fees = Rental.past_due_date.select{|rental|rental.client_id == self.id}.count
        fees *= 12
    end
    
    

    def self.first_rental(name, home_address, vhs)
        new_person =  Client.create(name: name, home_address: home_address)
        Rental.create(current: true, vhs_id: vhs.id, client_id: new_person.id)
    end

    def self.paid_most
        self.all.max_by{|client| client.cost_rentals}
    end 

    def my_rentals
        self.rentals
    end 

    def returned_one(vhs)
       
        my_vhs = self.my_rentals.select{|rental| rental.vhs.id == vhs.id}.first
        # my_vhs.toggle(:current).save
        my_vhs.update(current: false)
        
    end 

    
    
end

# - `Client.paid_most` - returns an instance who has spent most money at the store; one rental is $5,35 upfront (bonus: additional $12 charge for every late return — do not count those that have not yet been returned) 