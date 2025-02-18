# frozen_string_literal: true

module Sai
  class Decorator
    # Color manipulation methods for the {Decorator} class
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.1
    #
    # @abstract This module is meant to be included in the {Decorator} class to provide color manipulation methods
    # @api private
    module ColorManipulations
      # Darken the background color by a percentage
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api public
      #
      # @example
      #   decorator.on_blue.darken_text(0.5).decorate('Hello, world!').to_s #=> "\e[48;2;0;0;238mHello, world!\e[0m"
      #
      # @param amount [Float] the amount to darken the background color (0.0...1.0)
      #
      # @raise [ArgumentError] if the percentage is out of range
      # @return [Decorator] a new instance of Decorator with the darkened background color
      # @rbs (Float amount) -> Decorator
      def darken_background(amount)
        raise ArgumentError, "Invalid percentage: #{amount}" unless amount >= 0.0 && amount <= 1.0

        darken(amount, :background)
      end
      alias darken_bg darken_background

      # Darken the text color by a percentage
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api public
      #
      # @example
      #   decorator.blue.darken_text(0.5).decorate('Hello, world!').to_s #=> "\e[38;2;0;0;119mHello, world!\e[0m"
      #
      # @param amount [Float] the amount to darken the text color (0.0...1.0)
      #
      # @raise [ArgumentError] if the percentage is out of range
      # @return [Decorator] a new instance of Decorator with the darkened text color
      # @rbs (Float amount) -> Decorator
      def darken_text(amount)
        raise ArgumentError, "Invalid percentage: #{amount}" unless amount >= 0.0 && amount <= 1.0

        darken(amount, :foreground)
      end
      alias darken_fg darken_text
      alias darken_foreground darken_text

      # Lighten the background color by a percentage
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api public
      #
      # @example
      #   decorator.on_blue.lighten_background(0.5).decorate('Hello, world!').to_s
      #   #=> "\e[48;2;0;0;255mHello, world!\e[0m"
      #
      # @param amount [Float] the amount to lighten the background color (0.0...1.0)
      #
      # @raise [ArgumentError] if the percentage is out of range
      # @return [Decorator] a new instance of Decorator with the lightened background color
      # @rbs (Float amount) -> Decorator
      def lighten_background(amount)
        raise ArgumentError, "Invalid percentage: #{amount}" unless amount >= 0.0 && amount <= 1.0

        lighten(amount, :background)
      end
      alias lighten_bg lighten_background

      # Lighten the text color by a percentage
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api public
      #
      # @example
      #   decorator.blue.lighten_text(0.5).decorate('Hello, world!').to_s #=> "\e[38;2;0;0;127mHello, world!\e[0m"
      #
      # @param amount [Float] the amount to lighten the text color (0.0...1.0)
      #
      # @raise [ArgumentError] if the percentage is out of range
      # @return [Decorator] a new instance of Decorator with the lightened text color
      # @rbs (Float amount) -> Decorator
      def lighten_text(amount)
        raise ArgumentError, "Invalid percentage: #{amount}" unless amount >= 0.0 && amount <= 1.0

        lighten(amount, :foreground)
      end
      alias lighten_fg lighten_text
      alias lighten_foreground lighten_text

      private

      # Darken the foreground or background color by a specified amount
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api private
      #
      # @param amount [Float] a value between 0.0 and 1.0 to darken the color by
      # @param component [Symbol] the color component to darken
      #
      # @return [Decorator] a new instance of Decorator with the color darkened
      # @rbs (Float amount, Symbol component) -> Decorator
      def darken(amount, component)
        color = instance_variable_get(:"@#{component}")

        # @type self: Decorator

        dup.tap do |duped|
          if color
            rgb = Conversion::RGB.transform.darken(color, amount)
            duped.instance_variable_set(:"@#{component}", rgb)
          end
        end
      end

      # Lighten the foreground or background color by a specified amount
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api private
      #
      # @param amount [Float] a value between 0.0 and 1.0 to lighten the color by
      # @param component [Symbol] the color component to lighten
      #
      # @return [Decorator] a new instance of Decorator with the color lightened
      # @rbs (Float amount, Symbol component) -> Decorator
      def lighten(amount, component)
        color = instance_variable_get(:"@#{component}")

        # @type self: Decorator

        dup.tap do |duped|
          if color
            rgb = Conversion::RGB.transform.lighten(color, amount)
            duped.instance_variable_set(:"@#{component}", rgb)
          end
        end
      end
    end
  end
end
