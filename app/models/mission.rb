class Mission < ApplicationRecord
    belongs_to :scientist
    belongs_to :planet

    validates :name, presence:true
    validates :scientist, presence:true
    validates :planet, presence:true
    validates :scientist_id, uniqueness: { scope: :planet_id }
end
