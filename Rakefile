$: << File.expand_path('../lib', __FILE__)

require 'hb_exporter'
require 'logger'

desc 'list boards'
task :boards  do
  require_env(:name) do |name|
    HbExporter::User.new(name).list_boards
  end
end


desc 'export boards'
task :export_boards => [:boards] do
  require_env(:name) do |name|
    HbExporter::User.new(name).boards.each &:export_pins
  end
end

desc 'list pins of a board'
task :pins do
  require_env(:board_id) do |id|
    HbExporter::Board.new(id).list_pins
  end
end


desc 'export a board to local files'
task :export_board do
  require_env(:board_id) do |id|
    HbExporter::Board.load(id).export_pins
  end
end


def require_env name
  ENV[name.to_s].tap do |id|
    fail_with "usage: #{name}=#{name.to_s.upcase} rake" unless id
    yield id
  end
end


def fail_with msg
  STDERR.puts msg
  exit
end
