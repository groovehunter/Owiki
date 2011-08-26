class Term < ActiveRecord::Base

    has_and_belongs_to_many :entries

  def to_params
    "#{id}-#{name.parameterize}"
  end
end
