$: << File.expand_path('../lib', __FILE__)

require 'hb_exporter'
require 'logger'

desc 'list boards'
task :boards  do
  HbExporter::User.new('pigeonfenwick').list_boards
end


desc 'list pins of a board'
task :pins do
  require_board_id do |id|
    HbExporter::Board.new(id).list_pins
  end
end


desc 'export a board to local files'
task :export_board do
  require_board_id do |id|
    HbExporter::Board.load(id).export_pins
  end
end


def require_board_id
  ENV['board_id'].tap do |id|
    fail_with "usage: board_id=BOARD_ID rake pins" unless id
    yield id
  end
end


def fail_with msg
  STDERR.puts msg
  exit
end
