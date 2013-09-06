class Album < ActiveRecord::Base
  attr_accessible :name, :photos_attributes, :user_id
  has_many :photos, :dependent => :destroy
  belongs_to :user
  validates_presence_of :name, :user_id

  accepts_nested_attributes_for :photos, :allow_destroy => true


  def self.save_tags(val)
    
  end

end
