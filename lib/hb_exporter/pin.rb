require 'tempfile'

module HbExporter
  class Pin

    attr_accessor :key, :data

    def initialize(key, opt={})
      @key  = key
      @data = opt[:data]
    end


    def to_s
      "#<Pin #{key} #{image_url}>"
    end
    

    def image_url
      return nil unless key
      @image_url ||= "http://img.hb.aicdn.com/" << key
    end


    def export path: ''
      file_path = File.join(path, export_file_name)
      return true if File.size?(file_path)

      Tempfile.create(export_file_name) do |tmpfile|
        tmpfile << HTTParty.get(image_url)
        tmpfile.flush
        FileUtils.cp tmpfile, file_path
      end
      true
    end


    def export_file_name
      [key, suffix].join ?.
    end


    def suffix
      data['file']['type'].split('/').last
    end

  end
end
