# frozen_string_literal: true

require 'sai/conversion/rgb'

module Sai
  # A collection of named colors and their RGB values
  #
  # @author {https://aaronmallen.me Aaron Allen}
  # @since 0.3.1
  #
  # @api private
  module NamedColors
    # Standard ANSI color names and their RGB values
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.1
    #
    # @api private
    #
    # @return [Hash{Symbol => Array<Integer>}] the color names and RGB values
    ANSI = {
      black: [0, 0, 0],
      red: [205, 0, 0],
      green: [0, 205, 0],
      yellow: [205, 205, 0],
      blue: [0, 0, 238],
      magenta: [205, 0, 205],
      cyan: [0, 205, 205],
      white: [229, 229, 229],
      bright_black: [127, 127, 127],
      bright_red: [255, 0, 0],
      bright_green: [0, 255, 0],
      bright_yellow: [255, 255, 0],
      bright_blue: [92, 92, 255],
      bright_magenta: [255, 0, 255],
      bright_cyan: [0, 255, 255],
      bright_white: [255, 255, 255]
    }.freeze # Hash[Symbol, Array[Integer]]

    # CSS color names and their RGB values
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.1
    #
    # @api private
    #
    # @return [Hash{Symbol => Array<Integer>}] the color names and RGB values
    CSS = {
      alice_blue: [240, 248, 255],
      antique_white: [250, 235, 215],
      aqua: [0, 255, 255],
      aquamarine: [127, 255, 212],
      azure: [240, 255, 255],
      beige: [245, 245, 220],
      bisque: [255, 228, 196],
      blanched_almond: [255, 235, 205],
      brown: [165, 42, 42],
      burly_wood: [222, 184, 135],
      chartreuse: [127, 255, 0],
      chocolate: [210, 105, 30],
      coral: [255, 127, 80],
      cornsilk: [255, 248, 220],
      crimson: [220, 20, 60],
      dark_gray: [169, 169, 169],
      dark_olive_green: [85, 107, 47],
      dark_orchid: [153, 50, 204],
      dark_salmon: [233, 150, 122],
      dark_slate_blue: [72, 61, 139],
      dark_slate_gray: [47, 79, 79],
      deep_pink: [255, 20, 147],
      deep_sky_blue: [0, 191, 255],
      dim_gray: [105, 105, 105],
      dodger_blue: [30, 144, 255],
      firebrick: [178, 34, 34],
      floral_white: [255, 250, 240],
      forest_green: [34, 139, 34],
      fuchsia: [255, 0, 255],
      gainsboro: [220, 220, 220],
      ghost_white: [248, 248, 255],
      gold: [255, 215, 0],
      goldenrod: [218, 165, 32],
      gray: [128, 128, 128],
      honeydew: [240, 255, 240],
      indigo: [75, 0, 130],
      ivory: [255, 255, 240],
      khaki: [240, 230, 140],
      lavender: [230, 230, 250],
      lavender_blush: [255, 240, 245],
      lawn_green: [124, 252, 0],
      lemon_chiffon: [255, 250, 205],
      light_blue: [173, 216, 230],
      light_cyan: [224, 255, 255],
      light_goldenrod_yellow: [250, 250, 210],
      light_gray: [211, 211, 211],
      light_pink: [255, 182, 193],
      light_salmon: [255, 160, 122],
      light_sea_green: [32, 178, 170],
      light_sky_blue: [135, 206, 250],
      light_slate_gray: [119, 136, 153],
      light_yellow: [255, 255, 224],
      lime: [0, 255, 0],
      lime_green: [50, 205, 50],
      linen: [250, 240, 230],
      maroon: [128, 0, 0],
      medium_aquamarine: [102, 205, 170],
      medium_blue: [0, 0, 205],
      medium_sea_green: [60, 179, 113],
      medium_slate_blue: [123, 104, 238],
      midnight_blue: [25, 25, 112],
      mint_cream: [245, 255, 250],
      misty_rose: [255, 228, 225],
      moccasin: [255, 228, 181],
      navajo_white: [255, 222, 173],
      navy: [0, 0, 128],
      old_lace: [253, 245, 230],
      olive: [128, 128, 0],
      olive_drab: [107, 142, 35],
      orange: [255, 165, 0],
      orange_red: [255, 69, 0],
      pale_goldenrod: [238, 232, 170],
      pale_green: [152, 251, 152],
      pale_turquoise: [175, 238, 238],
      pale_violet_red: [219, 112, 147],
      papaya_whip: [255, 239, 213],
      peach_puff: [255, 218, 185],
      peru: [205, 133, 63],
      pink: [255, 192, 203],
      plum: [221, 160, 221],
      powder_blue: [176, 224, 230],
      royal_blue: [65, 105, 225],
      saddle_brown: [139, 69, 19],
      salmon: [250, 128, 114],
      sea_green: [46, 139, 87],
      sea_shell: [255, 245, 238],
      sienna: [160, 82, 45],
      silver: [192, 192, 192],
      sky_blue: [135, 206, 235],
      slate_blue: [106, 90, 205],
      slate_gray: [112, 128, 144],
      snow: [255, 250, 250],
      spring_green: [0, 255, 127],
      teal: [0, 128, 128],
      thistle: [216, 191, 216],
      tomato: [255, 99, 71],
      turquoise: [64, 224, 208],
      wheat: [245, 222, 179],
      white_smoke: [245, 245, 245],
      yellow_green: [154, 205, 50]
    }.freeze #: Hash[Symbol, Array[Integer]]

    # XTERM color names and their RGB values
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.1
    #
    # @api private
    #
    # @return [Hash{Symbol => Array<Integer>}] the color names and RGB values
    # rubocop:disable Naming/VariableNumber
    XTERM = {
      aqua_system: [0, 255, 255],
      aquamarine1: [95, 255, 215],
      aquamarine1_122: [135, 255, 215],
      aquamarine3: [95, 215, 175],
      black_system: [0, 0, 0],
      blue1: [0, 0, 255],
      blue_system: [0, 0, 255],
      blue_violet: [95, 0, 255],
      blue3: [0, 0, 175],
      blue3_20: [0, 0, 215],
      cadet_blue: [95, 175, 135],
      cadet_blue_73: [95, 175, 175],
      chartreuse1: [135, 255, 0],
      chartreuse2: [95, 255, 0],
      chartreuse2_112: [135, 215, 0],
      chartreuse3: [95, 175, 0],
      chartreuse3_76: [95, 215, 0],
      chartreuse4: [95, 135, 0],
      cornflower_blue: [95, 135, 255],
      cornsilk1: [255, 255, 215],
      cyan1: [0, 255, 255],
      cyan2: [0, 255, 215],
      cyan3: [0, 215, 175],
      dark_blue: [0, 0, 135],
      dark_cyan: [0, 175, 135],
      dark_goldenrod: [175, 135, 0],
      dark_green: [0, 95, 0],
      dark_khaki: [175, 175, 95],
      dark_magenta: [135, 0, 135],
      dark_magenta_91: [135, 0, 175],
      dark_olive_green1: [215, 255, 95],
      dark_olive_green1_192: [215, 255, 135],
      dark_olive_green2: [175, 255, 95],
      dark_olive_green3: [135, 175, 95],
      dark_olive_green3_113: [135, 215, 95],
      dark_olive_green3_149: [175, 215, 95],
      dark_orange: [255, 135, 0],
      dark_orange3: [175, 95, 0],
      dark_orange3_166: [215, 95, 0],
      dark_red: [95, 0, 0],
      dark_red_88: [135, 0, 0],
      dark_sea_green: [135, 175, 135],
      dark_sea_green1: [175, 255, 215],
      dark_sea_green1_193: [215, 255, 175],
      dark_sea_green2: [175, 215, 175],
      dark_sea_green2_157: [175, 255, 175],
      dark_sea_green3: [135, 215, 175],
      dark_sea_green3_150: [175, 215, 135],
      dark_sea_green4: [95, 135, 95],
      dark_sea_green4_71: [95, 175, 95],
      dark_slate_gray1: [135, 255, 255],
      dark_slate_gray2: [95, 255, 255],
      dark_slate_gray3: [135, 215, 215],
      dark_turquoise: [0, 215, 215],
      dark_violet: [135, 0, 215],
      dark_violet_128: [175, 0, 215],
      deep_pink1: [255, 0, 135],
      deep_pink1_199: [255, 0, 175],
      deep_pink2: [255, 0, 95],
      deep_pink3: [215, 0, 95],
      deep_pink3_162: [215, 0, 135],
      deep_pink4: [95, 0, 95],
      deep_pink4_89: [135, 0, 95],
      deep_pink4_125: [175, 0, 95],
      deep_sky_blue1: [0, 175, 255],
      deep_sky_blue2: [0, 175, 215],
      deep_sky_blue3: [0, 135, 175],
      deep_sky_blue3_32: [0, 135, 215],
      deep_sky_blue4: [0, 95, 95],
      deep_sky_blue4_24: [0, 95, 135],
      deep_sky_blue4_25: [0, 95, 175],
      dodger_blue1: [0, 135, 255],
      dodger_blue2: [0, 95, 255],
      dodger_blue3: [0, 95, 215],
      fuchsia_system: [255, 0, 255],
      gold1: [255, 215, 0],
      gold3: [175, 175, 0],
      gold3_178: [215, 175, 0],
      green1: [0, 255, 0],
      green3: [0, 175, 0],
      green3_40: [0, 215, 0],
      green4: [0, 135, 0],
      green_system: [0, 128, 0],
      green_yellow: [175, 255, 0],
      grey0: [0, 0, 0],
      grey100: [255, 255, 255],
      grey11: [28, 28, 28],
      grey15: [38, 38, 38],
      grey19: [48, 48, 48],
      grey23: [58, 58, 58],
      grey27: [68, 68, 68],
      grey3: [8, 8, 8],
      grey30: [78, 78, 78],
      grey35: [88, 88, 88],
      grey37: [95, 95, 95],
      grey39: [98, 98, 98],
      grey42: [108, 108, 108],
      grey46: [118, 118, 118],
      grey50: [128, 128, 128],
      grey53: [135, 135, 135],
      grey54: [138, 138, 138],
      grey58: [148, 148, 148],
      grey62: [158, 158, 158],
      grey66: [168, 168, 168],
      grey7: [18, 18, 18],
      grey70: [178, 178, 178],
      grey74: [188, 188, 188],
      grey78: [198, 198, 198],
      grey82: [208, 208, 208],
      grey84: [215, 215, 215],
      grey85: [218, 218, 218],
      grey89: [228, 228, 228],
      grey93: [238, 238, 238],
      grey_system: [128, 128, 128],
      honeydew2: [215, 255, 215],
      hot_pink: [255, 95, 175],
      hot_pink_206: [255, 95, 215],
      hot_pink2: [215, 95, 175],
      hot_pink3: [175, 95, 135],
      hot_pink3_168: [215, 95, 135],
      indian_red: [175, 95, 95],
      indian_red_167: [215, 95, 95],
      indian_red1: [255, 95, 95],
      indian_red1_204: [255, 95, 135],
      khaki1: [255, 255, 135],
      khaki3: [215, 215, 95],
      light_coral: [255, 135, 135],
      light_cyan1: [215, 255, 255],
      light_cyan3: [175, 215, 215],
      light_goldenrod1: [255, 255, 95],
      light_goldenrod2: [255, 215, 135],
      light_goldenrod2_221: [255, 215, 95],
      light_goldenrod3: [215, 175, 95],
      light_green: [135, 255, 95],
      light_green_120: [135, 255, 135],
      light_pink1: [255, 175, 175],
      light_pink3: [215, 135, 135],
      light_pink4: [135, 95, 95],
      light_salmon1: [255, 175, 135],
      light_salmon3: [175, 135, 95],
      light_salmon3_173: [215, 135, 95],
      light_sky_blue1: [175, 215, 255],
      light_sky_blue3: [135, 175, 175],
      light_sky_blue3_110: [135, 175, 215],
      light_slate_blue: [135, 135, 255],
      light_slate_grey: [135, 135, 175],
      light_steel_blue: [175, 175, 255],
      light_steel_blue1: [215, 215, 255],
      light_steel_blue3: [175, 175, 215],
      lime_system: [0, 255, 0],
      magenta1: [255, 0, 255],
      magenta2: [215, 0, 255],
      magenta2_200: [255, 0, 215],
      magenta3: [175, 0, 175],
      magenta3_163: [215, 0, 175],
      magenta3_164: [215, 0, 215],
      maroon_system: [128, 0, 0],
      medium_orchid: [175, 95, 215],
      medium_orchid1: [215, 95, 255],
      medium_orchid1_207: [255, 95, 255],
      medium_orchid3: [175, 95, 175],
      medium_purple: [135, 135, 215],
      medium_purple1: [175, 135, 255],
      medium_purple2: [175, 95, 255],
      medium_purple2_140: [175, 135, 215],
      medium_purple3: [135, 95, 175],
      medium_purple3_98: [135, 95, 215],
      medium_purple4: [95, 95, 135],
      medium_spring_green: [0, 255, 175],
      medium_turquoise: [95, 215, 215],
      medium_violet_red: [175, 0, 135],
      misty_rose1: [255, 215, 215],
      misty_rose3: [215, 175, 175],
      navy_blue: [0, 0, 95],
      navy_system: [0, 0, 128],
      navajo_white1: [255, 215, 175],
      navajo_white3: [175, 175, 135],
      olive_system: [128, 128, 0],
      orange1: [255, 175, 0],
      orange3: [215, 135, 0],
      orange4: [95, 95, 0],
      orange4_94: [135, 95, 0],
      orange_red1: [255, 95, 0],
      orchid: [215, 95, 215],
      orchid1: [255, 135, 255],
      orchid2: [255, 135, 215],
      pale_green1: [135, 255, 175],
      pale_green1_156: [175, 255, 135],
      pale_green3: [95, 215, 95],
      pale_green3_114: [135, 215, 135],
      pale_turquoise1: [175, 255, 255],
      pale_turquoise4: [95, 135, 135],
      pale_violet_red1: [255, 135, 175],
      pink1: [255, 175, 215],
      pink3: [215, 135, 175],
      plum1: [255, 175, 255],
      plum2: [215, 175, 255],
      plum3: [215, 135, 215],
      plum4: [135, 95, 135],
      purple: [135, 0, 255],
      purple_129: [175, 0, 255],
      purple3: [95, 0, 215],
      purple4: [95, 0, 135],
      purple4_55: [95, 0, 175],
      purple_system: [128, 0, 128],
      red1: [255, 0, 0],
      red3: [175, 0, 0],
      red3_160: [215, 0, 0],
      red_system: [255, 0, 0],
      rosy_brown: [175, 135, 135],
      royal_blue1: [95, 95, 255],
      salmon1: [255, 135, 95],
      sandy_brown: [255, 175, 95],
      silver_system: [192, 192, 192],
      sky_blue1: [135, 215, 255],
      sky_blue2: [135, 175, 255],
      sky_blue3: [95, 175, 215],
      slate_blue1: [135, 95, 255],
      slate_blue3: [95, 95, 175],
      slate_blue3_62: [95, 95, 215],
      spring_green1: [0, 255, 135],
      spring_green2: [0, 215, 135],
      spring_green2_47: [0, 255, 95],
      spring_green3: [0, 175, 95],
      spring_green3_41: [0, 215, 95],
      spring_green4: [0, 135, 95],
      steel_blue: [95, 135, 175],
      steel_blue1: [95, 175, 255],
      steel_blue1_81: [95, 215, 255],
      steel_blue3: [95, 135, 215],
      tan: [215, 175, 135],
      teal_system: [0, 128, 128],
      thistle1: [255, 215, 255],
      thistle3: [215, 175, 215],
      turquoise2: [0, 215, 255],
      turquoise4: [0, 135, 135],
      violet: [215, 135, 255],
      wheat1: [255, 255, 175],
      wheat4: [135, 135, 95],
      white_system: [255, 255, 255],
      yellow1: [255, 255, 0],
      yellow2: [215, 255, 0],
      yellow3: [175, 215, 0],
      yellow3_184: [215, 215, 0],
      yellow4: [135, 135, 0],
      yellow4_106: [135, 175, 0],
      yellow_system: [255, 255, 0]
    }.freeze #: Hash[Symbol, Array[Integer]]
    # rubocop:enable Naming/VariableNumber

    class << self
      # Look up an RGB value by color name
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api private
      #
      # @param name [String, Symbol] the color name
      #
      # @return [Array<Integer>] the RGB value
      # @rbs (String | Symbol name) -> Array[Integer]?
      def [](name)
        registry[name.to_sym]
      end

      # Get a list of all color names
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.3.1
      #
      # @api private
      #
      # @return [Array<Symbol>] the color names
      def names
        @names ||= registry.keys.uniq.sort
      end

      # Register a named color with an RGB or Hexadecimal value
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since unreleased
      #
      # @api private
      #
      # @param name [String, Symbol] the name of the color being registered
      # @param rgb_or_hex [Array<Integer>, String] the RGB or Hexadecimal value of the color
      #
      # @return [Boolean] `true` if the color was registered
      # @rbs (String | Symbol name, Array[Integer] | String rgb_or_hex) -> void
      def register(name, rgb_or_hex)
        key = name.to_s.downcase.to_sym
        provision_color(key, rgb_or_hex)
        install_color(key)
        true
      end

      private

      # Install the color methods onto {Sai} and {Sai::Decorator}
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since unreleased
      #
      # @api private
      #
      # @param name [Symbol] the name of the color to install
      #
      # @return [void]
      # @rbs (Symbol name) -> void
      def install_color(name)
        Sai::Decorator::NamedColors.install(name)
        Sai::Decorator::Delegation.install(Sai)
      end

      # Provision a color for the registry
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since unreleased
      #
      # @api private
      #
      # @param name [Symbol] the name of the color to register
      # @param rgb_or_hex [Array<Integer>, String] the RGB or Hexadecimal value of the color
      #
      # @return [void]
      # @rbs (Symbol name, Array[Integer] | String rgb_or_hex) -> void
      def provision_color(name, rgb_or_hex)
        rgb = Conversion::RGB.resolve(rgb_or_hex)
        registry[name] = rgb
        @names = nil
      end

      # The Sai named colors registry
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since unreleased
      #
      # @api private
      #
      # @return [Hash{Symbol => Array<Integer>}] the named colors registry
      def registry
        thread_lock.synchronize do
          @registry ||= CSS.merge(XTERM).merge(ANSI)
        end
      end

      # A Mutex for thread safety
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since unreleased
      #
      # @api private
      #
      # @return [Mutex] the thread lock
      # @rbs () -> Mutex
      def thread_lock
        @thread_lock ||= Mutex.new
      end
    end
  end
end
