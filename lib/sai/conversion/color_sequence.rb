# frozen_string_literal: true

require 'sai/ansi'
require 'sai/conversion/rgb'
require 'sai/mode_selector'

module Sai
  module Conversion
    # ANSI escape sequence utilities
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.1.0
    #
    # @api private
    module ColorSequence
      # @rbs!
      #   type style_type = :foreground | :background

      class << self
        # Convert a color to the appropriate ANSI escape sequence
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param color [String, Array<Integer>] the color to convert
        # @param mode [Integer] the terminal color mode
        # @param style_type [Symbol] the type of color (foreground or background)
        #
        # @return [String] the ANSI escape sequence
        # @rbs (Array[Integer] | String | Symbol color, Integer mode, ?style_type style_type) -> String
        def resolve(color, mode, style_type = :foreground)
          rgb = RGB.resolve(color)
          style_type = validate_style_type(style_type) #: style_type

          case mode
          when ModeSelector::TWENTY_FOUR_BIT then true_color(rgb, style_type)
          when ModeSelector::EIGHT_BIT then advanced(rgb, style_type)
          when ModeSelector::FOUR_BIT then ansi(rgb, style_type)
          when ModeSelector::THREE_BIT then basic(rgb, style_type)
          else
            ''
          end
        end

        private

        # Convert RGB values to an 8-bit color sequence
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param rgb [Array<Integer>] the RGB components
        # @param style_type [Symbol] the type of color (foreground or background)
        #
        # @return [String] the ANSI escape sequence
        # @rbs (Array[Integer] rgb, style_type type) -> String
        def advanced(rgb, style_type)
          code = style_type == :background ? 48 : 38
          color_code = if rgb.uniq.size == 1
                         RGB.index.grayscale(rgb)
                       else
                         RGB.index.color_cube(rgb)
                       end

          "\e[#{code};5;#{color_code}m"
        end

        # Convert RGB values to a 4-bit ANSI color sequence
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param rgb [Array<Integer>] the RGB components
        # @param style_type [Symbol] the type of color (foreground or background)
        #
        # @return [String] the ANSI escape sequence
        # @rbs (Array[Integer] rgb, style_type style_type) -> String
        def ansi(rgb, style_type)
          r, g, b = rgb.map { |c| c / 255.0 } #: [Float, Float, Float]
          brightness = (r + g + b) / 3.0
          is_bright = brightness > 0.5

          color = RGB.classify.closest_ansi_color(r, g, b)
          code = base_color_for_style_type(ANSI::COLOR_CODES[color], style_type)
          code += 60 if is_bright
          "\e[#{code}m"
        end

        # Convert a base color to a foreground or background sequence
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param base_code [Integer] the base color code
        # @param style_type [Symbol] the type of color (foreground or background)
        #
        # @return [Integer] the code for the color sequence
        # @rbs (Integer base_code, style_type style_type) -> Integer
        def base_color_for_style_type(base_code, style_type)
          style_type == :background ? base_code + 40 : base_code + 30
        end

        # Convert RGB values to a 3-bit basic color sequence
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param rgb [Array<Integer>] the RGB components
        # @param style_type [Symbol] the type of color (foreground or background)
        #
        # @return [String] the ANSI escape sequence
        # @rbs (Array[Integer] rgb, style_type style_type) -> String
        def basic(rgb, style_type)
          r, g, b = rgb.map { |c| c / 255.0 } #: [Float, Float, Float]
          color = RGB.classify.closest_ansi_color(r, g, b)
          code = base_color_for_style_type(ANSI::COLOR_CODES[color], style_type)
          "\e[#{code}m"
        end

        # Convert RGB values to a true color (24-bit) sequence
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param rgb [Array<Integer>] the RGB components
        # @param style_type [Symbol] the type of color (foreground or background)
        #
        # @return [String] the ANSI escape sequence
        # @rbs (Array[Integer] rgb, style_type type) -> String
        def true_color(rgb, style_type)
          code = style_type == :background ? 48 : 38
          "\e[#{code};2;#{rgb.join(';')}m"
        end

        # Validate a color style type
        #
        # @author {https://aaronmallen.me Aaron Allen}
        # @since 0.1.0
        #
        # @api private
        #
        # @param style_type [Symbol] the style type to validate
        #
        # @raise [ArgumentError] if the style type is invalid
        # @return [Symbol] the validated style type
        # @rbs (Symbol style_type) -> Symbol
        def validate_style_type(style_type)
          raise ArgumentError, "Invalid style type: #{style_type}" unless %i[foreground background].include?(style_type)

          style_type
        end
      end
    end
  end
end
