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

      #puts "save #{image_url} to #{file_path}"

      File.open(file_path, 'wb') do |file|
        file.write_nonblock (HTTParty.get(image_url))
        true
      end
    end


    def export_file_name
      [key, suffix].join ?.
    end


    def suffix
      data['file']['type'].split('/').last
    end

  end
end
