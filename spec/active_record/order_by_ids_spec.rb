RSpec.describe ActiveRecord::OrderByIds do
  before do
    ActiveRecord::Base.establish_connection database_config

    silence_stream(STDOUT) do
      ActiveRecord::Schema.define do
        create_table :users do |t|
          t.integer :parent_id
          t.string :study_id
        end
      end
    end

    class User < ActiveRecord::Base
    end
  end

  after do
    silence_stream(STDOUT) do
      ActiveRecord::Schema.define do
        drop_table :users
      end
    end
  end

  context ".order_by_ids" do
    it "orders records by supplied id order" do
      user1 = User.create(id: 1)
      user2 = User.create(id: 2)
      user3 = User.create(id: 3)

      expect(User.order_by_ids([2,3,1])).to eq [user2, user3, user1]
    end
  end

  context ".order_by" do
    it "orders records by supplied map of columns and ids" do
      user3 = User.create(parent_id: 3)
      user2 = User.create(parent_id: 2)
      user1 = User.create(parent_id: 1)

      expect(User.order_by(parent_id: [2,3,1])).to eq [user2, user3, user1]
    end

    it "puts missing values last" do
      user4 = User.create(parent_id: 4)
      user3 = User.create(parent_id: 3)
      user2 = User.create(parent_id: 2)
      user1 = User.create(parent_id: 1)

      expect(User.order_by(parent_id: [2,3,1])).to eq [user2, user3, user1, user4]
    end

    it "puts nil values last" do
      user4 = User.create(parent_id: nil)
      user3 = User.create(parent_id: 3)
      user2 = User.create(parent_id: 2)
      user1 = User.create(parent_id: 1)

      expect(User.order_by(parent_id: [2,3,1])).to eq [user2, user3, user1, user4]
    end

    it "can handle non-integer values" do
      userA = User.create(study_id: "A")
      userB = User.create(study_id: "B")
      userC = User.create(study_id: "C")
      expect(User.order_by(study_id: %w[B A C])).to eq [userB, userA, userC]
    end
  end
end
