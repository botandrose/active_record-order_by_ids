RSpec.describe ActiveRecord::OrderByIds do
  before do
    ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

    silence_stream(STDOUT) do
      ActiveRecord::Schema.define do
        create_table :users
      end
    end

    class User < ActiveRecord::Base
    end
  end
 
  it "orders by supplied id order" do
    user1 = User.create(id: 1)
    user2 = User.create(id: 2)
    user3 = User.create(id: 3)
    
    expect(User.order_by_ids([2,3,1])).to eq [user2, user3, user1]
  end
end
