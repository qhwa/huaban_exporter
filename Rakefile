$: << File.expand_path('../lib', __FILE__)

require 'hb_exporter'
require 'logger'

desc '列出一个用户的所有画板 (user=用户名 rake boards)'
task :boards  do
  require_env(:user) do |name|
    HbExporter::User.new(name).list_boards
  end
end


desc '导出用户所有的画板图片到本地 (user=用户名 rake export_boards)'
task :export_boards => [:boards] do
  require_env(:user) do |name|
    HbExporter::User.new(name).boards.each &:export_pins
  end
end

desc '列出一个画板所有的采集 (board_id=画板id rake pins)'
task :pins do
  require_env(:board_id) do |id|
    HbExporter::Board.new(id).list_pins
  end
end


desc '导出一个画板的所有图片到本地 (board_id=画板id  rake export_board)'
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
