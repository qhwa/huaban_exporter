require 'hb_exporter/recursively_fetch'

module HbExporter
  class User

    include RecursivelyFetch


    attr_accessor :name

    def initialize(name)
      @name = name
    end


    def list_boards
      boards.each do |b|
        puts "- #{b.id.to_s.rjust(20).cyan} #{b.title.to_s.bold} - #{b.desc}"
      end
    end


    def export_all_boards
      bards
    end


    def boards
      @boards ||= fetch_boards.map do |data|
        Board.new(data['board_id'], title: data['title'], desc: data['description'])
      end
    end


    private

      def fetch_boards
        recursively_fetch(api_path, []) do |res, ret|
          boards = res['user']['boards']
          if boards.nil? or boards.empty?
            nil
          else
            @max = boards.last['board_id'].to_i
            boards
          end
        end
      end


      def api_path
        "http://huaban.com/#{name}"
      end

  end
end
