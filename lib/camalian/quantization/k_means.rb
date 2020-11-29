# frozen_string_literal: true

module Camalian
  module Quantization
    class KMeans # :nodoc:
      INIT_TRIES = 10

      def process(colors, count)
        # Its faster to extract unique colors once
        colors = colors.uniq
        means = initial_means(colors, count)

        done = false

        until done
          groups = group_by_means(colors, means)
          new_means = groups.map do |group|
            Palette.new(group).average_color
          end
          common = means & new_means

          done = common.size == means.size
          means = new_means
        end

        Palette.new(means)
      end

      private

      def initial_means(colors, count)
        count = colors.size if count > colors.size
        means = []
        tries = 0
        while means.size != count && tries < INIT_TRIES
          (count - means.size).times { means << colors[rand(colors.size)] }
          means.uniq!
          tries += 1
        end

        means
      end

      def group_by_means(pixels, means)
        groups = {}

        pixels.each do |p|
          distances = means.map { |m| p.rgb_distance(m) }
          min_distance_index = distances.index(distances.min)

          groups[min_distance_index] ||= []
          groups[min_distance_index] << p
        end

        groups.values
      end
    end
  end
end
