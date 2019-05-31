class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_created, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost_max}
  validate  :picture_size

  private

  def picture_size
    return if picture.size <= Settings.picture_size.megabytes
    errors.add :picture, I18n.t("errors.error3")
  end
end
