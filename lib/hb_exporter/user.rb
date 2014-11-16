require 'hb_exporter/helper/recursively_fetch'

module HbExporter
  class User

    include Helper::RecursivelyFetch


    attr_accessor :name

    def initialize(name)
      @name = name
    end


    def list_boards
      id_max_len    = [2, boards.map(&:id).max.to_s.size].max
      count_max_len = [5, boards.map(&:pins_count).max.to_s.size].max

      puts [
        "id".rjust(id_max_len),
        "count".ljust(count_max_len),
        "title"
      ].join(" ")

      boards.each do |b|
        puts "#{b.id.to_s.rjust(id_max_len).cyan} #{b.pins_count.to_s.ljust(count_max_len).cyan} #{b.title.to_s.bold} - #{b.desc}"
      end
    end


    def export_all_boards
      bards
    end


    def boards
      @boards ||= fetch_boards.map do |data|
        Board.new(data['board_id'], title: data['title'], desc: data['description'], pins_count: data['pin_count'])
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
