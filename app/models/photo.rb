class Photo < ActiveRecord::Base
  belongs_to :album
  attr_accessible :title, :image, :tags_attributes

  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
