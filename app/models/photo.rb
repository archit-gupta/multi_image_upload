class Photo < ActiveRecord::Base
  belongs_to :album
  attr_accessible :title, :image, :tags_attributes

  has_many :photo_tags
  has_many :tags, :through => :photo_tags

  accepts_nested_attributes_for :tags, :reject_if => proc { |attributes| attributes['name'].blank? }
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
