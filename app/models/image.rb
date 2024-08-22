class Image < ActiveRecord::Base
    has_attached_file :image, :styles =>{ :thumb =>"158x69#", :medium =>"#754x" }
    do_not_validate_attachment_file_type :image
  
    def create
      image = Paperclip.io_adapters.for(params[:image]) 
      image.original_filename = "dashboard.png"
      Image.create!(image: image)
    end
  end
  