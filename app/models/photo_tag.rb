class PhotoTag < ActiveRecord::Base
  belongs_to :photo
  belongs_to :tag
  attr_accessible :photo_id, :tag_id
end
