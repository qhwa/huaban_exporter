module HbExporter

  module Helper

    module RecursivelyFetch

      include HTTParty
      format :json

      def recursively_fetch(path, ret, &block)
        opts = {
          query: {
            limit: 100,
            max: @max,
            wtfl: 1
          },

          headers: {
            'X-Requested-With' => 'XMLHttpRequest'
          }
        }
        res = ::HbExporter::Helper::RecursivelyFetch.get(path, opts)
        block.call(res).tap do |data|
          if data
            return recursively_fetch(path, ret + data, &block)
          else
            return ret
          end
        end
      end

    end

  end
end
