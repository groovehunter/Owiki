class Term < ActiveRecord::Base

    has_and_belongs_to_many :entries
    validates_uniqueness_of :name
    
  def to_params
    "#{id}-#{name.parameterize}"
  end
end
