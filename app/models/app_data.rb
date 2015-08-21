require 'yaml'

class AppData
  attr_reader :name, :link

  def initialize(name, link)
    @name = name
    @link = link
  end

  def self.from_yaml(file_path)
    YAML.load_file(file_path).map do |app_data|
      self.new(app_data.fetch("name"), app_data.fetch("link"))
    end
  end
end
