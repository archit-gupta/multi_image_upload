class Album < ActiveRecord::Base
  attr_accessible :name, :photos_attributes, :user_id
  has_many :photos, :dependent => :destroy
  belongs_to :user
  validates_presence_of :name, :user_id
  validates_presence_of :photos, :message => "can't be blank"

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |attributes| attributes['image'].blank? }


  before_save do
    self.photos.each do |photo|
      photo.tags.first.name.delete(" ").split(",").each_with_index do |tag,index|
        if index == 0
          if Tag.find_by_name(tag).present?
            this_tag = Tag.find_by_name(tag)
            if photo.photo_tags.present?
              photo.photo_tags.first.update_attributes(:tag_id => this_tag.id)  
            else 
              photo.photo_tags.build(:tag_id => this_tag.id)
            end
            photo.tags.first.delete
          else
            photo.tags.first.update_attributes(:name => tag)  
          end
        else
          if Tag.find_by_name(tag).present?
            this_tag = Tag.find_by_name(tag)
            photo.photo_tags.build(:tag_id => this_tag.id)
          else
            photo.tags.build(:name => tag)
          end
        end
      end
    end
  end

end
