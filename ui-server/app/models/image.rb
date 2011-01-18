class Image < ActiveRecord::Base
  has_many :regions
  belongs_to :runner, :counter_cache => true

  validates_format_of :url,
                :with => URI::regexp(%w(http https)), :message => "invalid_url_protocol"
  validates_format_of :url,
                :with => /.*\.(jpg|jpeg)$/i, :message => "invalid_image_format"

  STATUS_COMPLETED  = "completed"
  STATUS_FAILED     = "failed"
  STATUS_PROCESSING = "processing"

  def complete!
    self.completed = true
    self.save!
  end
  
  def failed!
    self.failed = true
    self.save!
  end

  def status
    if self.completed
      return STATUS_COMPLETED
    elsif self.failed
      return STATUS_FAILED
    else
      return STATUS_PROCESSING
    end
  end
end
