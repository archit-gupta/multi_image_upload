class Album < ActiveRecord::Base
  attr_accessible :name, :photos_attributes, :user_id
  has_many :photos, :dependent => :destroy
  belongs_to :user
  validates_presence_of :name, :user_id
  validates_presence_of :photos, :message => "can't be blank"

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |attributes| attributes['image'].blank? }


  before_save do
    self.photos.each do |photo|
      photo.tags.each {|t| t.destroy}
      photo.photo_tags.each {|pt| pt.destroy}
      photo.tags.first.name.delete(" ").split(",").each do |tag|
          if Tag.find_by_name(tag.downcase).present?
            this_tag = Tag.find_by_name(tag)
            photo.photo_tags.build(:tag_id => this_tag.id)
          else
            photo.tags.build(:name => tag)
          end
      end
    end
  end

end
