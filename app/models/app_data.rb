require 'yaml'

class AppData
  attr_reader :name, :link, :description, :image_url

  def initialize(name:, link:, description: nil, image_url: nil)
    @name = name
    @link = link
    @description = description
    @image_url = image_url
  end

  def self.from_yaml(file_path)
    YAML.load_file(file_path).map do |app_data|
      self.new(name: app_data.fetch("name"),
               link: app_data.fetch("link"),
               description: app_data.fetch("description", "no info"),
               image_url: app_data.fetch("image_url", "images/no_image.jpg"),
              )
    end
  end
end
