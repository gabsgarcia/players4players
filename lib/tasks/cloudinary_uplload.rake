namespace :cloudinary do
  desc "Upload all images from assets/images to Cloudinary"
  task upload_images: :environment do
    require 'cloudinary'

    # Path to your images
    images_path = Rails.root.join('app', 'assets', 'images')

    # Go through all images in the directory
    Dir.glob("#{images_path}/**/*.{jpg,jpeg,png,gif}").each do |image_path|
      # Get the filename without the path
      filename = File.basename(image_path)

      # Upload the image to Cloudinary
      puts "Uploading #{filename}..."

      begin
        result = Cloudinary::Uploader.upload(image_path,
          public_id: filename.split('.').first, # Use filename as the public_id
          overwrite: true # Overwrite if already exists
        )

        puts "Successfully uploaded #{filename} to Cloudinary. URL: #{result['secure_url']}"
      rescue => e
        puts "Failed to upload #{filename}: #{e.message}"
      end
    end

    puts "All images uploaded!"
  end
end
