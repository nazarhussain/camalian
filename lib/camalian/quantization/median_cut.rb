# frozen_string_literal: true

module Camalian
  module Quantization
    class MedianCut # :nodoc:
      SplitInfo = Struct.new(:range, :group_index, :color, keyword_init: true)
      def process(colors, count)
        # Its faster to extract unique colors once
        colors = colors.uniq
        groups = [colors]
        limit = [count, colors.size].min

        loop do
          split_info = determine_group_split(groups)
          group1, group2 = split_group(groups[split_info.group_index], split_info)
          groups.reject!.each_with_index { |_g, index| index == split_info.group_index }
          groups << group1 unless group1.empty?
          groups << group2 unless group2.empty?

          break if groups.size >= limit
        end

        palletes = groups.map { |g| Palette.new(g.uniq) }
        average_colors = palletes.map(&:average_color)

        Palette.new(average_colors[0...count])
      end

      private

      def determine_group_split(groups)
        stats = []

        groups.each_with_index do |group, index|
          reds = group.map(&:r)
          greens = group.map(&:g)
          blues = group.map(&:b)

          ranges = []
          ranges << SplitInfo.new(group_index: index, range: reds.max - reds.min, color: :r) unless reds.empty?
          ranges << SplitInfo.new(group_index: index, range: greens.max - greens.min, color: :g) unless greens.empty?
          ranges << SplitInfo.new(group_index: index, range: blues.max - blues.min, color: :b) unless blues.empty?

          stats << ranges.max_by(&:range)
        end

        stats.max_by(&:range)
      end

      def split_group(group, split_info)
        split_color = split_info.color
        colors = group.sort_by { |pixel| pixel.send split_color }

        return [[colors[0]], [colors[1]]] if colors.size == 2

        median_index = colors.size / 2
        median_value = colors[median_index].send split_color

        group1 = []
        group2 = []

        colors.each do |color|
          if color.send(split_color) <= median_value
            group1 << color
          else
            group2 << color
          end
        end

        [group1, group2]
      end
    end
  end
end
