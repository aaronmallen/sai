# frozen_string_literal: true

require 'sai/decorator'
require 'sai/support'
require 'sai/terminal/capabilities'
require 'singleton'

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
# * {#decorator} - Returns a new instance of {Decorator} for method chaining
# * {#terminal_color_support} - Returns the color support capabilities of the current terminal
#
# The Sai module itself responds to all the same methods as {Decorator}, excluding methods used for applying
# decorations (apply, call, decorate, encode). These methods are directly delegated to a new {Decorator} instance
#
# @author {https://aaronmallen.me Aaron Allen}
# @since unreleased
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
    ignored_decorator_methods = %i[apply call decorate encode]
    Decorator.instance_methods(false).reject { |m| ignored_decorator_methods.include?(m) }.each do |method|
      define_method(method) do |*arguments, **keyword_arguments|
        Decorator.new(send(:color_mode)).public_send(method, *arguments, **keyword_arguments)
      end
    end

    # @rbs!
    #   def black: () -> self
    #   def blink: () -> self
    #   def blue: () -> self
    #   def bold: () -> self
    #   def bright_black: () -> self
    #   def bright_blue: () -> self
    #   def bright_cyan: () -> self
    #   def bright_green: () -> self
    #   def bright_magenta: () -> self
    #   def bright_red: () -> self
    #   def bright_white: () -> self
    #   def bright_yellow: () -> self
    #   def conceal: () -> self
    #   def cyan: () -> self
    #   def dim: () -> self
    #   def green: () -> self
    #   def italic: () -> self
    #   def magenta: () -> self
    #   def no_blink: () -> self
    #   def no_conceal: () -> self
    #   def no_italic: () -> self
    #   def no_reverse: () -> self
    #   def no_strike: () -> self
    #   def no_underline: () -> self
    #   def normal_intensity: () -> self
    #   def on_black: () -> self
    #   def on_blue: () -> self
    #   def on_bright_black: () -> self
    #   def on_bright_blue: () -> self
    #   def on_bright_cyan: () -> self
    #   def on_bright_green: () -> self
    #   def on_bright_magenta: () -> self
    #   def on_bright_red: () -> self
    #   def on_bright_white: () -> self
    #   def on_bright_yellow: () -> self
    #   def on_cyan: () -> self
    #   def on_green: () -> self
    #   def on_magenta: () -> self
    #   def on_red: () -> self
    #   def on_white: () -> self
    #   def on_yellow: () -> self
    #   def rapid_blink: () -> self
    #   def red: () -> self
    #   def reverse: () -> self
    #   def strike: () -> self
    #   def underline: () -> self
    #   def white: () -> self
    #   def yellow: () -> self

    # The supported color modes for the terminal
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since unreleased
    #
    # @api public
    #
    # @example Check the color support of the terminal
    #   Sai.support.ansi? # => true
    #   Sai.support.basic? # => true
    #   Sai.support.bit8? # => true
    #   Sai.support.no_color? # => false
    #   Sai.support.true_color? # => true
    #
    # @return [Support] the color support
    # @rbs () -> Support
    def support
      @support ||= Support.new(color_mode).freeze
    end

    private

    # Detect the color capabilities of the terminal
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since unreleased
    #
    # @api private
    #
    # @return [Integer] the color mode
    # @rbs () -> Integer
    def color_mode
      Thread.current[:sai_color_mode] ||= Terminal::Capabilities.detect_color_support
    end
  end

  # A helper method to initialize an instance of {Decorator}
  #
  # @author {https://aaronmallen.me Aaron Allen}
  # @since unreleased
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
  # @return [Decorator] the Decorator instance
  # @rbs () -> Decorator
  def decorator
    Decorator.new(Terminal::Capabilities.detect_color_support)
  end

  # The supported color modes for the terminal
  #
  # @author {https://aaronmallen.me Aaron Allen}
  # @since unreleased
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
  #   MyClass.new.terminal_color_support.bit8? # => true
  #   MyClass.new.terminal_color_support.no_color? # => false
  #   MyClass.new.terminal_color_support.true_color? # => true
  #
  # @return [Support] the color support
  # @rbs () -> Support
  def terminal_color_support
    Sai.support
  end
end
