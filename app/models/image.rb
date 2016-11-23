class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_attached_file :file, styles: { post: "500" }
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  before_save :extract_dimensions
  store :dimensions, accessors: [ :width, :height ], coder: JSON

  private

  def extract_dimensions
    tempfile = file.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
    end
  end
end
