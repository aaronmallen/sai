# frozen_string_literal: true

require 'sai/ansi'
require 'sai/ansi/sequence_processor'
require 'sai/ansi/sequenced_string'
require 'sai/conversion/cache'
require 'sai/conversion/color_sequence'
require 'sai/conversion/rgb'
require 'sai/decorator'
require 'sai/decorator/delegator'
require 'sai/mode_selector'
require 'sai/registry'
require 'sai/support'

# An elegant color management system for crafting sophisticated CLI applications
#
# Sai (彩) - meaning 'coloring' or 'paint' in Japanese - is a powerful and intuitive system for managing color output in
# command-line applications. Drawing inspiration from traditional Japanese artistic techniques, Sai brings vibrancy and
# harmony to terminal interfaces through its sophisticated color management
#
# Sai empowers developers to create beautiful, colorful CLI applications that maintain visual consistency across
# different terminal capabilities. Like its artistic namesake, it combines simplicity and sophistication to bring rich,
# adaptive color to your terminal interfaces
#
# When included in a class or module, Sai provides the following instance methods:
# * {#color_mode} - Returns an interface to select Sai color modes
# * {#decorator} - Returns a new instance of {Decorator} for method chaining
# * {#terminal_color_support} - Returns the color support capabilities of the current terminal
#
# The Sai module itself responds to all the same methods as {Decorator}, excluding methods used for applying
# decorations (apply, call, decorate, encode). These methods are directly delegated to a new {Decorator} instance
#
# @author {https://aaronmallen.me Aaron Allen}
# @since 0.1.0
#
# @api public
#
# @example Using Sai as a module
#   class MyClass
#     include Sai
#   end
#
#   my_class = MyClass.new
#   my_class.decorator.red.on_blue.bold.decorate('Hello, World!')
#   #=> "\e[38;2;205;0;0m\e[48;2;0;0;238m\e[1mHello, World!\e[0m"
#
#   my_class.terminal_color_support.true_color? # => true
#
# @example Using Sai directly
#   Sai.red.on_blue.bold.decorate('Hello, World!')
#   #=> "\e[38;2;205;0;0m\e[48;2;0;0;238m\e[1mHello, World!\e[0m"
#
#   Sai.support.true_color? # => true
module Sai
  class << self
    include Decorator::Delegator

    # The Sai {ModeSelector mode selector}
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.2.0
    #
    # @api public
    #
    # @example
    #   Sai.mode.auto #=> 4
    #
    # @return [ModeSelector] the mode selector
    # @rbs () -> singleton(ModeSelector)
    def mode
      ModeSelector
    end

    # Register a custom name and color
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.2
    #
    # @api public
    #
    # @example Register a color
    #   Sai.register(:my_color, '#CF4C5F')
    #   Sai.register(:my_color, [207, 76, 95])
    #
    #   Sai.my_color.decorate('Hello, world!').to_s #=> "\e[38;2;207;76;95mHello, world!\e[0m"
    #
    # @param name [String, Symbol] the name of the color to register
    # @param rgb_or_hex [Array<Integer>, String] the RGB values or hex code to register
    #
    # @return [void]
    # @rbs (String | Symbol name, Array[Integer] | String rgb_or_hex) -> void
    def register(name, rgb_or_hex)
      Registry.register(name, rgb_or_hex)
    end

    # Sequence a string with ANSI escape codes
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.0
    #
    # @api public
    #
    # @example Sequence a string with ANSI escape codes
    #   Sai.sequence("\e[38;2;205;0;0mHello, World!\e[0m") #=> #<Sai::ANSI::SequencedString:0x123>
    #
    # @param text [String] the text to sequence
    #
    # @return [ANSI::SequencedString] the sequenced string
    # @rbs (String text) -> ANSI::SequencedString
    def sequence(text)
      ANSI::SequencedString.new(text)
    end

    # The supported color modes for the terminal
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.1.0
    #
    # @api public
    #
    # @example Check the color support of the terminal
    #   Sai.support.ansi? # => true
    #   Sai.support.basic? # => true
    #   Sai.support.advanced? # => true
    #   Sai.support.no_color? # => false
    #   Sai.support.true_color? # => true
    #
    # @return [Support] the color support
    # @rbs () -> singleton(Support)
    def support
      Support
    end

    private

    # Handle a color registration
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.4.0
    #
    # @api private
    #
    # @param color_name [Symbol] the color name
    #
    # @return [void]
    # @rbs (Symbol color_name) -> void
    def on_color_registration(color_name)
      [color_name, "on_#{color_name}"].each do |method|
        singleton_class.undef_method(method) if singleton_class.method_defined?(method)
        singleton_class.define_method(method) { Decorator.new.send(method) }
      end
    end
  end

  # A helper method that provides Sai color modes
  #
  # @author {https://aaronmallen.me Aaron Allen}
  # @since 0.2.0
  #
  # @api public
  #
  # @example
  #   class MyClass
  #     include Sai
  #   end
  #
  #   MyClass.new.color_mode.ansi #=> 2
  #
  # @return [ModeSelector] the mode selector
  # @rbs () -> singleton(ModeSelector)
  def color_mode
    ModeSelector
  end

  # A helper method to initialize an instance of {Decorator}
  #
  # @author {https://aaronmallen.me Aaron Allen}
  # @since 0.1.0
  #
  # @api public
  #
  # @example Initialize a new instance of {Decorator}
  #   class MyClass
  #     include Sai
  #   end
  #
  #   MyClass.new.decorator.blue.on_red.bold.decorate('Hello, world!')
  #   #=> "\e[38;5;21m\e[48;5;160m\e[1mHello, world!\e[0m"
  #
  #   MyClass.new.decorator(mode: Sai.mode.no_color)
  #   #=> "Hello, world!"
  #
  # @param mode [Integer] the color mode to use
  #
  # @return [Decorator] the Decorator instance
  # @rbs (?mode: Integer) -> Decorator
  def decorator(mode: Sai.mode.auto)
    Decorator.new(mode:)
  end

  # The supported color modes for the terminal
  #
  # @author {https://aaronmallen.me Aaron Allen}
  # @since 0.1.0
  #
  # @api public
  #
  # @example Check the color support of the terminal
  #   class MyClass
  #     include Sai
  #   end
  #
  #   MyClass.new.terminal_color_support.ansi? # => true
  #   MyClass.new.terminal_color_support.basic? # => true
  #   MyClass.new.terminal_color_support.advanced? # => true
  #   MyClass.new.terminal_color_support.no_color? # => false
  #   MyClass.new.terminal_color_support.true_color? # => true
  #
  # @return [Support] the color support
  # @rbs () -> singleton(Support)
  def terminal_color_support
    Support
  end
end

Sai::Registry.subscribe(Sai)
Sai::Registry.subscribe(Sai::Decorator)
Sai::ANSI.install
