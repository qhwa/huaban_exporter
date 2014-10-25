require 'fileutils'
require 'thread'
require 'ruby-progressbar'
require 'hb_exporter/pin'
require 'hb_exporter/helper/recursively_fetch'

module HbExporter

  class Board

    include Helper::RecursivelyFetch

    attr_accessor :id, :title, :desc


    def self.load(id)
      new(id).tap &:load_data
    end


    def initialize(id, opt={})
      @id = id
      @title    = opt[:title]
      @desc     = opt[:desc]
    end


    def load_data
      opts = {
        headers: { 'X-Requested-With' => 'XMLHttpRequest' }
      }
      HTTParty.get(api_path, opts)['board'].tap do |data|
        @title = data['title']
        @desc  = data['description']
      end
    end


    def to_s
      "#<board##{id} #{title} - #{desc}>"
    end


    def list_pins
      pins.each do |pin|
        puts "#{pin.key.to_s.rjust(60).cyan} #{pin.image_url}"
      end
    end


    def pins
      @pins ||= fetch_pins.map do |data|
        Pin.new(data['file']['key'], data: data)
      end
    end


    def export_pins
      board_path = prepare_export_path
      counter = pins.size

      thread_count = 5

      puts title.green
      progress_bar.reset

      pins.partition { rand thread_count }.each do |pins|
        Thread.new {
          pins.each do |pin|
            pin.export path: board_path
            progress_bar.increment
            counter -= 1
          end
        }
      end

      while counter > 0
      end
      progress_bar.finish
    end


    private


      def fetch_pins
        recursively_fetch api_path, [] do |res|
          pins = res['board']['pins']
          if pins.nil? or pins.empty?
            nil
          else
            @max = pins.last['pin_id'].to_i - 1
            pins
          end
        end
      end


      def api_path
        "http://huaban.com/boards/#{id}"
      end


      def prepare_export_path
        "output/#{id}-#{escaped_name}".tap do |export_path|
          FileUtils.mkdir_p export_path
        end
      end


      def escaped_name
        title.gsub(%r{/}, ',')
      end


      def progress_bar
        @progress_bar ||= ProgressBar.create(
          :format         => "%t - %c / %C %b>%i %p%% %t",
          :total          => pins.size
        )
      end


  end
end

