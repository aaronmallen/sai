# frozen_string_literal: true

require 'forwardable'
require 'sai/ansi'
require 'sai/ansi/sequence_processor'

module Sai
  module ANSI
    # A representation of a ANSI encoded string and its individual {SequencedString::Segment segments}
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.0
    #
    # @api public
    class SequencedString
      # @rbs skip
      extend Forwardable
      include Enumerable #[Segment]

      # @!method each
      #   Iterate over each segment
      #
      #   @author {https://aaronmallen.me Aaron Allen}
      #   @since 0.3.0
      #
      #   @api public
      #   @return [Enumerator] the Enumerator
      #
      # @!method map
      #   Map over segments
      #
      #   @author {https://aaronmallen.me Aaron Allen}
      #   @since 0.3.0
      #
      #   @api public
      #   @return [Array] the segments to map over
      #
      # @!method size
      #   Number of segments
      #
      #   @author {https://aaronmallen.me Aaron Allen}
      #   @since 0.3.0
      #
      #   @api public
      #
      #   @return [Integer] the number of segments
      def_delegators :@segments, :each, :empty?, :map, :size # steep:ignore NoMethod

      # @rbs!
      #   def each: () { (Segment) -> void } -> SequencedString
      #   def empty?: () -> bool
      #   def map: () { (Segment) -> untyped } -> Array[untyped]
      #   def size: () -> Integer

      # Initialize a new instance of SequencedString
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api private
      #
      # @param string [String] the sequenced string to Segment
      #
      # @return [SequencedString] the new instance of SequencedString
      # @rbs (String string) -> void
      def initialize(string)
        @segments = ANSI::SequenceProcessor.process(string).map do |segment_options|
          Segment.new(**segment_options) # steep:ignore InsufficientKeywordArguments
        end
      end

      # Fetch a segment by index
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example
      #   string = SequencedString.new("\e[31mred\e[0m")
      #   string[0] #=> #<SequencedString::Segment:0x00007f9b3b8b3e10>
      #
      # @param index [Integer] the index of the segment to fetch
      #
      # @return [Segment, nil] the segment at the index
      # @rbs (Integer index) -> Segment?
      def [](index)
        @segments[index]
      end

      # Compare the SequencedString to another object
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example
      #   string = "\e[31mred\e[0m"
      #   SequencedString.new(string) == string #=> true
      #
      # @param other [Object] the object to compare to
      #
      # @return [Boolean] `true` if the SequencedString is equal to the other object, `false` otherwise
      # @rbs (untyped other) -> bool
      def ==(other)
        (other.is_a?(self.class) && to_s == other.to_s) ||
          (other.is_a?(String) && to_s == self.class.new(other).to_s)
      end

      # Combine a sequenced string with another object
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example
      #   sequenced_string = SequencedString.new("\e[31mred\e[0m")
      #   sequenced_string + " is a color" #=> "\e[31mred\e[0m is a color"
      #
      # @param other [Object] the object to combine with
      #
      # @return [SequencedString] the combined string
      # @rbs (untyped other) -> SequencedString
      def +(other)
        string = to_s + other.to_s
        self.class.new(string)
      end

      # Return just the raw text content with **no ANSI sequences**
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example
      #   string = SequencedString.new("Normal \e[31mred\e[0m")
      #   string.stripped #=> "Normal red"
      #
      # @return [String] the concatenation of all segment text without color or style
      def stripped
        map(&:text).join
      end

      # Return the fully reconstructed string with **all ANSI sequences** (foreground, background, style)
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example
      #   string = SequencedString.new("\e[31mred\e[0m")
      #   string.to_s #=> "\e[31mred\e[0m"
      #
      # @return [String]
      def to_s
        build_string
      end
      alias to_str to_s

      # Return a string with everything except **background** color sequences removed
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example Remove all background colors
      #   string = SequencedString.new("\e[41mBack\e[0m \e[1mBold\e[0m")
      #   string.without_background #=> "\e[1mBold\e[0m"
      #
      # @return [SequencedString] new instance with background colors removed
      # @rbs () -> SequencedString
      def without_background
        self.class.new(build_string(skip_background: true))
      end

      # Return a string containing *style* sequences but **no foreground or background colors**
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example Remove all colors
      #   string = SequencedString.new("\e[31mred\e[0m \e[1mbold\e[0m")
      #   string.without_color #=> "\e[1mbold\e[0m"
      #
      # @return [SequencedString] new instance with all colors removed
      # @rbs () -> SequencedString
      def without_color
        self.class.new(build_string(skip_background: true, skip_foreground: true))
      end

      # Return a string with everything except **foreground** color sequences removed
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example Remove all foreground colors
      #   string = SequencedString.new("\e[41mBack\e[0m \e[1mBold\e[0m")
      #   string.without_foreground #=> "\e[41mBack\e[0m \e[1mBold\e[0m"
      #
      # @return [SequencedString] new instance with foreground colors removed
      # @rbs () -> SequencedString
      def without_foreground
        self.class.new(build_string(skip_foreground: true))
      end

      # Return a string with specified styles removed
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      #
      # @example Remove all styles
      #   string = SequencedString.new("\e[31mred\e[0m \e[1mbold\e[0m")
      #   string.without_style #=> "\e[31mred\e[0m"
      #
      # @example Remove specific style
      #   string = SequencedString.new("\e[1;4mBold and Underlined\e[0m")
      #   string.without_style(:bold) #=> "\e[4mUnderlined\e[0m"
      #
      # @param styles [Array<Symbol>] specific styles to remove (default: all)
      #
      # @return [SequencedString] new instance with specified styles removed
      def without_style(*styles)
        skipped_styles = styles.empty? ? ANSI::STYLES.keys : styles.map(&:to_sym)
        self.class.new(build_string(skip_styles: skipped_styles))
      end

      private

      # Build the color sequences for a segment
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api private
      #
      # @param segment [Segment] the segment to build color sequences for
      # @param skip_background [Boolean] whether to skip background colors
      # @param skip_foreground [Boolean] whether to skip foreground colors
      #
      # @return [Array<String>] the color sequences
      # @rbs (Segment segment, ?skip_background: bool, ?skip_foreground: bool) -> Array[String]
      def build_color_sequences(segment, skip_background: false, skip_foreground: false)
        [
          (skip_foreground ? nil : segment.foreground),
          (skip_background ? nil : segment.background)
        ].compact
      end

      # Build a string with specified parts skipped
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api private
      #
      # @param skip_background [Boolean] whether to skip background colors
      # @param skip_foreground [Boolean] whether to skip foreground colors
      # @param skip_styles [Array<Symbol>] styles to skip
      #
      # @return [String] the built string
      # @rbs (?skip_background: bool, ?skip_foreground: bool, ?skip_styles: Array[Symbol]) -> String
      def build_string(skip_background: false, skip_foreground: false, skip_styles: [])
        map do |segment|
          color_sequences = build_color_sequences(segment, skip_background:, skip_foreground:)
          style_sequences = build_style_sequences(segment, skip_styles: skip_styles)
          sequences = color_sequences + style_sequences

          out = sequences.empty? ? +'' : "\e[#{sequences.compact.join(';')}m"
          out << segment.text
          out << ANSI::RESET unless sequences.empty?
          out
        end.join
      end

      # Build the style sequences for a segment
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api private
      #
      # @param segment [Segment] the segment to build style sequences for
      # @param skip_styles [Array<Symbol>] styles to skip
      #
      # @return [Array<String>] the style sequences
      # @rbs (Segment segment, ?skip_styles: Array[Symbol]) -> Array[String]
      def build_style_sequences(segment, skip_styles: [])
        return [] if skip_styles.include?(:all)

        segment.styles.filter_map do |style_code|
          style_name = ANSI::STYLES.key(style_code.to_i)
          style_code unless skip_styles.include?(style_name)
        end
      end

      # A segment of an ANSI encoded string
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.0
      #
      # @api public
      class Segment
        # The background color sequences for the Segment
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        #
        # @return [String, nil] the background color sequences
        attr_reader :background #: String?

        # The foreground color sequences for the Segment
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        #
        # @return [String, nil] the foreground color sequences
        attr_reader :foreground #: String?

        # The {Location} of the encoded string within the {SequencedString}
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        #
        # @return [Location] the {Location}
        attr_reader :encoded_location #: Location
        alias encoded_loc encoded_location

        # The {Location} of the encoded string without it's encoding within the {SequencedString}
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        #
        # @return [Location] the {Location}
        attr_reader :stripped_location #: Location
        alias stripped_loc stripped_location

        # The style sequences (bold, underline, etc...) for the segment
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        #
        # @return [Array<String>] the style sequences
        attr_reader :styles #: Array[String]

        # The raw text of the Segment without any of its ANSI sequences
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        #
        # @return [String]
        attr_reader :text #: String

        # Initialize a new instance of Segment
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api private
        #
        # @param options [Hash{Symbol => Object}] the options to initialize the Segment with
        # @option options background [String, nil] the Segment {#background}
        # @option options foreground [String, nil] the Segment {#foreground}
        # @option options encoded_end [Integer] the {Location#end_position end_position} of the Segment
        #   {#encoded_location}
        # @option options encoded_start [Integer] the {Location#start_position start_position} of the Segment
        #   {#encoded_location}
        # @option options stripped_end [Integer] the {Location#end_position end_position} of the Segment
        #   {#stripped_location}
        # @option options stripped_start [Integer] the {Location#start_position start_position} of the Segment
        #   {#stripped_location}
        # @option options styles [Array<String>] the Segment {#styles}
        # @option options text [String] the Segment {#text}
        #
        # @return [Segment] the new instance of Segment
        # @rbs (
        #   ?background: String?,
        #   ?foreground: String?,
        #   encoded_end: Integer,
        #   encoded_start: Integer,
        #   stripped_end: Integer,
        #   stripped_start: Integer,
        #   ?styles: Array[String],
        #   text: String
        #   ) -> void
        def initialize(**options)
          @background = options.fetch(:background, nil)
          @foreground = options.fetch(:foreground, nil)
          @encoded_location = Location.new(
            end_position: options.fetch(:encoded_end), #: Integer
            start_position: options.fetch(:encoded_start) #: Integer
          )
          @stripped_location = Location.new(
            end_position: options.fetch(:stripped_end), #: Integer
            start_position: options.fetch(:stripped_start) #: Integer
          )
          @styles = options.fetch(:styles, [])
          @text = options.fetch(:text)

          freeze
        end

        # The location of the {Segment} within a {SequencedString}
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.3.0
        #
        # @api public
        class Location
          # The ending position of the Location
          #
          # @author {https://aaronmallen.me Aaron Allen}
          # @since 0.3.0
          #
          # @api public
          #
          # @return [Integer] the end position
          attr_reader :end_position #: Integer
          alias end_pos end_position

          # The starting position of the Location
          #
          # @author {https://aaronmallen.me Aaron Allen}
          # @since 0.3.0
          #
          # @api public
          #
          # @return [Integer] the start position
          attr_reader :start_position #: Integer
          alias start_pos start_position

          # Initialize a new instance of Location
          #
          # @author {https://aaronmallen.me Aaron Allen}
          # @since 0.3.0
          #
          # @api private
          #
          # @param end_position [Integer] the {#end_position} of the location
          # @param start_position [Integer] the {#start_position} of the location
          #
          # @return [Location] the new instance of Location
          # @rbs (end_position: Integer, start_position: Integer) -> void
          def initialize(end_position:, start_position:)
            @end_position = end_position
            @start_position = start_position
            freeze
          end
        end
      end
    end
  end
end
