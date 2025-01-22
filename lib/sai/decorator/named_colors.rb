# frozen_string_literal: true

require 'sai/named_colors'

module Sai
  class Decorator
    # Named color methods for the {Decorator} class
    #
    # @author {https://aaronmallen.me Aaron Allen}
    # @since 0.3.1
    #
    # @abstract This module is meant to be included in the {Decorator} class to provide named color methods
    # @api private
    #
    # @note For each named color, two methods are dynamically generated:
    #   * color_name - Applies the color to the foreground
    #   * on_color_name - Applies the color to the backgroundAll color methods return {Decorator}
    # @see Sai::NamedColors Sai::NamedColors for available color names
    #
    # @example Using a named color
    #   decorator.azure.decorate('Hello')      #=> "\e[38;2;0;127;255mHello\e[0m"
    #   decorator.on_azure.decorate('Hello')   #=> "\e[48;2;0;127;255mHello\e[0m"
    module NamedColors
      # @rbs!
      #   def alice_blue: () -> Decorator
      #   def antique_white: () -> Decorator
      #   def aqua: () -> Decorator
      #   def aqua_system: () -> Decorator
      #   def aquamarine: () -> Decorator
      #   def aquamarine1: () -> Decorator
      #   def aquamarine1_122: () -> Decorator
      #   def aquamarine3: () -> Decorator
      #   def azure: () -> Decorator
      #   def beige: () -> Decorator
      #   def bisque: () -> Decorator
      #   def black: () -> Decorator
      #   def black_system: () -> Decorator
      #   def blanched_almond: () -> Decorator
      #   def blue: () -> Decorator
      #   def blue1: () -> Decorator
      #   def blue3: () -> Decorator
      #   def blue3_20: () -> Decorator
      #   def blue_system: () -> Decorator
      #   def blue_violet: () -> Decorator
      #   def bright_black: () -> Decorator
      #   def bright_blue: () -> Decorator
      #   def bright_cyan: () -> Decorator
      #   def bright_green: () -> Decorator
      #   def bright_magenta: () -> Decorator
      #   def bright_red: () -> Decorator
      #   def bright_white: () -> Decorator
      #   def bright_yellow: () -> Decorator
      #   def brown: () -> Decorator
      #   def burly_wood: () -> Decorator
      #   def cadet_blue: () -> Decorator
      #   def cadet_blue_73: () -> Decorator
      #   def chartreuse: () -> Decorator
      #   def chartreuse1: () -> Decorator
      #   def chartreuse2: () -> Decorator
      #   def chartreuse2_112: () -> Decorator
      #   def chartreuse3: () -> Decorator
      #   def chartreuse3_76: () -> Decorator
      #   def chartreuse4: () -> Decorator
      #   def chocolate: () -> Decorator
      #   def coral: () -> Decorator
      #   def cornflower_blue: () -> Decorator
      #   def cornsilk: () -> Decorator
      #   def cornsilk1: () -> Decorator
      #   def crimson: () -> Decorator
      #   def cyan: () -> Decorator
      #   def cyan1: () -> Decorator
      #   def cyan2: () -> Decorator
      #   def cyan3: () -> Decorator
      #   def dark_blue: () -> Decorator
      #   def dark_cyan: () -> Decorator
      #   def dark_goldenrod: () -> Decorator
      #   def dark_gray: () -> Decorator
      #   def dark_green: () -> Decorator
      #   def dark_khaki: () -> Decorator
      #   def dark_magenta: () -> Decorator
      #   def dark_magenta_91: () -> Decorator
      #   def dark_olive_green: () -> Decorator
      #   def dark_olive_green1: () -> Decorator
      #   def dark_olive_green1_192: () -> Decorator
      #   def dark_olive_green2: () -> Decorator
      #   def dark_olive_green3: () -> Decorator
      #   def dark_olive_green3_113: () -> Decorator
      #   def dark_olive_green3_149: () -> Decorator
      #   def dark_orange: () -> Decorator
      #   def dark_orange3: () -> Decorator
      #   def dark_orange3_166: () -> Decorator
      #   def dark_orchid: () -> Decorator
      #   def dark_red: () -> Decorator
      #   def dark_red_88: () -> Decorator
      #   def dark_salmon: () -> Decorator
      #   def dark_sea_green: () -> Decorator
      #   def dark_sea_green1: () -> Decorator
      #   def dark_sea_green1_193: () -> Decorator
      #   def dark_sea_green2: () -> Decorator
      #   def dark_sea_green2_157: () -> Decorator
      #   def dark_sea_green3: () -> Decorator
      #   def dark_sea_green3_150: () -> Decorator
      #   def dark_sea_green4: () -> Decorator
      #   def dark_sea_green4_71: () -> Decorator
      #   def dark_slate_blue: () -> Decorator
      #   def dark_slate_gray: () -> Decorator
      #   def dark_slate_gray1: () -> Decorator
      #   def dark_slate_gray2: () -> Decorator
      #   def dark_slate_gray3: () -> Decorator
      #   def dark_turquoise: () -> Decorator
      #   def dark_violet: () -> Decorator
      #   def dark_violet_128: () -> Decorator
      #   def deep_pink: () -> Decorator
      #   def deep_pink1: () -> Decorator
      #   def deep_pink1_199: () -> Decorator
      #   def deep_pink2: () -> Decorator
      #   def deep_pink3: () -> Decorator
      #   def deep_pink3_162: () -> Decorator
      #   def deep_pink4: () -> Decorator
      #   def deep_pink4_125: () -> Decorator
      #   def deep_pink4_89: () -> Decorator
      #   def deep_sky_blue: () -> Decorator
      #   def deep_sky_blue1: () -> Decorator
      #   def deep_sky_blue2: () -> Decorator
      #   def deep_sky_blue3: () -> Decorator
      #   def deep_sky_blue3_32: () -> Decorator
      #   def deep_sky_blue4: () -> Decorator
      #   def deep_sky_blue4_24: () -> Decorator
      #   def deep_sky_blue4_25: () -> Decorator
      #   def dim_gray: () -> Decorator
      #   def dodger_blue: () -> Decorator
      #   def dodger_blue1: () -> Decorator
      #   def dodger_blue2: () -> Decorator
      #   def dodger_blue3: () -> Decorator
      #   def firebrick: () -> Decorator
      #   def floral_white: () -> Decorator
      #   def forest_green: () -> Decorator
      #   def fuchsia: () -> Decorator
      #   def fuchsia_system: () -> Decorator
      #   def gainsboro: () -> Decorator
      #   def ghost_white: () -> Decorator
      #   def gold: () -> Decorator
      #   def gold1: () -> Decorator
      #   def gold3: () -> Decorator
      #   def gold3_178: () -> Decorator
      #   def goldenrod: () -> Decorator
      #   def gray: () -> Decorator
      #   def green: () -> Decorator
      #   def green1: () -> Decorator
      #   def green3: () -> Decorator
      #   def green3_40: () -> Decorator
      #   def green4: () -> Decorator
      #   def green_system: () -> Decorator
      #   def green_yellow: () -> Decorator
      #   def grey0: () -> Decorator
      #   def grey100: () -> Decorator
      #   def grey11: () -> Decorator
      #   def grey15: () -> Decorator
      #   def grey19: () -> Decorator
      #   def grey23: () -> Decorator
      #   def grey27: () -> Decorator
      #   def grey3: () -> Decorator
      #   def grey30: () -> Decorator
      #   def grey35: () -> Decorator
      #   def grey37: () -> Decorator
      #   def grey39: () -> Decorator
      #   def grey42: () -> Decorator
      #   def grey46: () -> Decorator
      #   def grey50: () -> Decorator
      #   def grey53: () -> Decorator
      #   def grey54: () -> Decorator
      #   def grey58: () -> Decorator
      #   def grey62: () -> Decorator
      #   def grey66: () -> Decorator
      #   def grey7: () -> Decorator
      #   def grey70: () -> Decorator
      #   def grey74: () -> Decorator
      #   def grey78: () -> Decorator
      #   def grey82: () -> Decorator
      #   def grey84: () -> Decorator
      #   def grey85: () -> Decorator
      #   def grey89: () -> Decorator
      #   def grey93: () -> Decorator
      #   def grey_system: () -> Decorator
      #   def honeydew: () -> Decorator
      #   def honeydew2: () -> Decorator
      #   def hot_pink: () -> Decorator
      #   def hot_pink2: () -> Decorator
      #   def hot_pink3: () -> Decorator
      #   def hot_pink3_168: () -> Decorator
      #   def hot_pink_206: () -> Decorator
      #   def indian_red: () -> Decorator
      #   def indian_red1: () -> Decorator
      #   def indian_red1_204: () -> Decorator
      #   def indian_red_167: () -> Decorator
      #   def indigo: () -> Decorator
      #   def ivory: () -> Decorator
      #   def khaki: () -> Decorator
      #   def khaki1: () -> Decorator
      #   def khaki3: () -> Decorator
      #   def lavender: () -> Decorator
      #   def lavender_blush: () -> Decorator
      #   def lawn_green: () -> Decorator
      #   def lemon_chiffon: () -> Decorator
      #   def light_blue: () -> Decorator
      #   def light_coral: () -> Decorator
      #   def light_cyan: () -> Decorator
      #   def light_cyan1: () -> Decorator
      #   def light_cyan3: () -> Decorator
      #   def light_goldenrod1: () -> Decorator
      #   def light_goldenrod2: () -> Decorator
      #   def light_goldenrod2_221: () -> Decorator
      #   def light_goldenrod3: () -> Decorator
      #   def light_goldenrod_yellow: () -> Decorator
      #   def light_gray: () -> Decorator
      #   def light_green: () -> Decorator
      #   def light_green_120: () -> Decorator
      #   def light_pink: () -> Decorator
      #   def light_pink1: () -> Decorator
      #   def light_pink3: () -> Decorator
      #   def light_pink4: () -> Decorator
      #   def light_salmon: () -> Decorator
      #   def light_salmon1: () -> Decorator
      #   def light_salmon3: () -> Decorator
      #   def light_salmon3_173: () -> Decorator
      #   def light_sea_green: () -> Decorator
      #   def light_sky_blue: () -> Decorator
      #   def light_sky_blue1: () -> Decorator
      #   def light_sky_blue3: () -> Decorator
      #   def light_sky_blue3_110: () -> Decorator
      #   def light_slate_blue: () -> Decorator
      #   def light_slate_gray: () -> Decorator
      #   def light_slate_grey: () -> Decorator
      #   def light_steel_blue: () -> Decorator
      #   def light_steel_blue1: () -> Decorator
      #   def light_steel_blue3: () -> Decorator
      #   def light_yellow: () -> Decorator
      #   def lime: () -> Decorator
      #   def lime_green: () -> Decorator
      #   def lime_system: () -> Decorator
      #   def linen: () -> Decorator
      #   def magenta: () -> Decorator
      #   def magenta1: () -> Decorator
      #   def magenta2: () -> Decorator
      #   def magenta2_200: () -> Decorator
      #   def magenta3: () -> Decorator
      #   def magenta3_163: () -> Decorator
      #   def magenta3_164: () -> Decorator
      #   def maroon: () -> Decorator
      #   def maroon_system: () -> Decorator
      #   def medium_aquamarine: () -> Decorator
      #   def medium_blue: () -> Decorator
      #   def medium_orchid: () -> Decorator
      #   def medium_orchid1: () -> Decorator
      #   def medium_orchid1_207: () -> Decorator
      #   def medium_orchid3: () -> Decorator
      #   def medium_purple: () -> Decorator
      #   def medium_purple1: () -> Decorator
      #   def medium_purple2: () -> Decorator
      #   def medium_purple2_140: () -> Decorator
      #   def medium_purple3: () -> Decorator
      #   def medium_purple3_98: () -> Decorator
      #   def medium_purple4: () -> Decorator
      #   def medium_sea_green: () -> Decorator
      #   def medium_slate_blue: () -> Decorator
      #   def medium_spring_green: () -> Decorator
      #   def medium_turquoise: () -> Decorator
      #   def medium_violet_red: () -> Decorator
      #   def midnight_blue: () -> Decorator
      #   def mint_cream: () -> Decorator
      #   def misty_rose: () -> Decorator
      #   def misty_rose1: () -> Decorator
      #   def misty_rose3: () -> Decorator
      #   def moccasin: () -> Decorator
      #   def navajo_white: () -> Decorator
      #   def navajo_white1: () -> Decorator
      #   def navajo_white3: () -> Decorator
      #   def navy: () -> Decorator
      #   def navy_blue: () -> Decorator
      #   def navy_system: () -> Decorator
      #   def old_lace: () -> Decorator
      #   def olive: () -> Decorator
      #   def olive_drab: () -> Decorator
      #   def olive_system: () -> Decorator
      #   def on_alice_blue: () -> Decorator
      #   def on_antique_white: () -> Decorator
      #   def on_aqua: () -> Decorator
      #   def on_aqua_system: () -> Decorator
      #   def on_aquamarine: () -> Decorator
      #   def on_aquamarine1: () -> Decorator
      #   def on_aquamarine1_122: () -> Decorator
      #   def on_aquamarine3: () -> Decorator
      #   def on_azure: () -> Decorator
      #   def on_beige: () -> Decorator
      #   def on_bisque: () -> Decorator
      #   def on_black: () -> Decorator
      #   def on_black_system: () -> Decorator
      #   def on_blanched_almond: () -> Decorator
      #   def on_blue: () -> Decorator
      #   def on_blue1: () -> Decorator
      #   def on_blue3: () -> Decorator
      #   def on_blue3_20: () -> Decorator
      #   def on_blue_system: () -> Decorator
      #   def on_blue_violet: () -> Decorator
      #   def on_bright_black: () -> Decorator
      #   def on_bright_blue: () -> Decorator
      #   def on_bright_cyan: () -> Decorator
      #   def on_bright_green: () -> Decorator
      #   def on_bright_magenta: () -> Decorator
      #   def on_bright_red: () -> Decorator
      #   def on_bright_white: () -> Decorator
      #   def on_bright_yellow: () -> Decorator
      #   def on_brown: () -> Decorator
      #   def on_burly_wood: () -> Decorator
      #   def on_cadet_blue: () -> Decorator
      #   def on_cadet_blue_73: () -> Decorator
      #   def on_chartreuse: () -> Decorator
      #   def on_chartreuse1: () -> Decorator
      #   def on_chartreuse2: () -> Decorator
      #   def on_chartreuse2_112: () -> Decorator
      #   def on_chartreuse3: () -> Decorator
      #   def on_chartreuse3_76: () -> Decorator
      #   def on_chartreuse4: () -> Decorator
      #   def on_chocolate: () -> Decorator
      #   def on_coral: () -> Decorator
      #   def on_cornflower_blue: () -> Decorator
      #   def on_cornsilk: () -> Decorator
      #   def on_cornsilk1: () -> Decorator
      #   def on_crimson: () -> Decorator
      #   def on_cyan: () -> Decorator
      #   def on_cyan1: () -> Decorator
      #   def on_cyan2: () -> Decorator
      #   def on_cyan3: () -> Decorator
      #   def on_dark_blue: () -> Decorator
      #   def on_dark_cyan: () -> Decorator
      #   def on_dark_goldenrod: () -> Decorator
      #   def on_dark_gray: () -> Decorator
      #   def on_dark_green: () -> Decorator
      #   def on_dark_khaki: () -> Decorator
      #   def on_dark_magenta: () -> Decorator
      #   def on_dark_magenta_91: () -> Decorator
      #   def on_dark_olive_green: () -> Decorator
      #   def on_dark_olive_green1: () -> Decorator
      #   def on_dark_olive_green1_192: () -> Decorator
      #   def on_dark_olive_green2: () -> Decorator
      #   def on_dark_olive_green3: () -> Decorator
      #   def on_dark_olive_green3_113: () -> Decorator
      #   def on_dark_olive_green3_149: () -> Decorator
      #   def on_dark_orange: () -> Decorator
      #   def on_dark_orange3: () -> Decorator
      #   def on_dark_orange3_166: () -> Decorator
      #   def on_dark_orchid: () -> Decorator
      #   def on_dark_red: () -> Decorator
      #   def on_dark_red_88: () -> Decorator
      #   def on_dark_salmon: () -> Decorator
      #   def on_dark_sea_green: () -> Decorator
      #   def on_dark_sea_green1: () -> Decorator
      #   def on_dark_sea_green1_193: () -> Decorator
      #   def on_dark_sea_green2: () -> Decorator
      #   def on_dark_sea_green2_157: () -> Decorator
      #   def on_dark_sea_green3: () -> Decorator
      #   def on_dark_sea_green3_150: () -> Decorator
      #   def on_dark_sea_green4: () -> Decorator
      #   def on_dark_sea_green4_71: () -> Decorator
      #   def on_dark_slate_blue: () -> Decorator
      #   def on_dark_slate_gray: () -> Decorator
      #   def on_dark_slate_gray1: () -> Decorator
      #   def on_dark_slate_gray2: () -> Decorator
      #   def on_dark_slate_gray3: () -> Decorator
      #   def on_dark_turquoise: () -> Decorator
      #   def on_dark_violet: () -> Decorator
      #   def on_dark_violet_128: () -> Decorator
      #   def on_deep_pink: () -> Decorator
      #   def on_deep_pink1: () -> Decorator
      #   def on_deep_pink1_199: () -> Decorator
      #   def on_deep_pink2: () -> Decorator
      #   def on_deep_pink3: () -> Decorator
      #   def on_deep_pink3_162: () -> Decorator
      #   def on_deep_pink4: () -> Decorator
      #   def on_deep_pink4_125: () -> Decorator
      #   def on_deep_pink4_89: () -> Decorator
      #   def on_deep_sky_blue: () -> Decorator
      #   def on_deep_sky_blue1: () -> Decorator
      #   def on_deep_sky_blue2: () -> Decorator
      #   def on_deep_sky_blue3: () -> Decorator
      #   def on_deep_sky_blue3_32: () -> Decorator
      #   def on_deep_sky_blue4: () -> Decorator
      #   def on_deep_sky_blue4_24: () -> Decorator
      #   def on_deep_sky_blue4_25: () -> Decorator
      #   def on_dim_gray: () -> Decorator
      #   def on_dodger_blue: () -> Decorator
      #   def on_dodger_blue1: () -> Decorator
      #   def on_dodger_blue2: () -> Decorator
      #   def on_dodger_blue3: () -> Decorator
      #   def on_firebrick: () -> Decorator
      #   def on_floral_white: () -> Decorator
      #   def on_forest_green: () -> Decorator
      #   def on_fuchsia: () -> Decorator
      #   def on_fuchsia_system: () -> Decorator
      #   def on_gainsboro: () -> Decorator
      #   def on_ghost_white: () -> Decorator
      #   def on_gold: () -> Decorator
      #   def on_gold1: () -> Decorator
      #   def on_gold3: () -> Decorator
      #   def on_gold3_178: () -> Decorator
      #   def on_goldenrod: () -> Decorator
      #   def on_gray: () -> Decorator
      #   def on_green: () -> Decorator
      #   def on_green1: () -> Decorator
      #   def on_green3: () -> Decorator
      #   def on_green3_40: () -> Decorator
      #   def on_green4: () -> Decorator
      #   def on_green_system: () -> Decorator
      #   def on_green_yellow: () -> Decorator
      #   def on_grey0: () -> Decorator
      #   def on_grey100: () -> Decorator
      #   def on_grey11: () -> Decorator
      #   def on_grey15: () -> Decorator
      #   def on_grey19: () -> Decorator
      #   def on_grey23: () -> Decorator
      #   def on_grey27: () -> Decorator
      #   def on_grey3: () -> Decorator
      #   def on_grey30: () -> Decorator
      #   def on_grey35: () -> Decorator
      #   def on_grey37: () -> Decorator
      #   def on_grey39: () -> Decorator
      #   def on_grey42: () -> Decorator
      #   def on_grey46: () -> Decorator
      #   def on_grey50: () -> Decorator
      #   def on_grey53: () -> Decorator
      #   def on_grey54: () -> Decorator
      #   def on_grey58: () -> Decorator
      #   def on_grey62: () -> Decorator
      #   def on_grey66: () -> Decorator
      #   def on_grey7: () -> Decorator
      #   def on_grey70: () -> Decorator
      #   def on_grey74: () -> Decorator
      #   def on_grey78: () -> Decorator
      #   def on_grey82: () -> Decorator
      #   def on_grey84: () -> Decorator
      #   def on_grey85: () -> Decorator
      #   def on_grey89: () -> Decorator
      #   def on_grey93: () -> Decorator
      #   def on_grey_system: () -> Decorator
      #   def on_honeydew: () -> Decorator
      #   def on_honeydew2: () -> Decorator
      #   def on_hot_pink: () -> Decorator
      #   def on_hot_pink2: () -> Decorator
      #   def on_hot_pink3: () -> Decorator
      #   def on_hot_pink3_168: () -> Decorator
      #   def on_hot_pink_206: () -> Decorator
      #   def on_indian_red: () -> Decorator
      #   def on_indian_red1: () -> Decorator
      #   def on_indian_red1_204: () -> Decorator
      #   def on_indian_red_167: () -> Decorator
      #   def on_indigo: () -> Decorator
      #   def on_ivory: () -> Decorator
      #   def on_khaki: () -> Decorator
      #   def on_khaki1: () -> Decorator
      #   def on_khaki3: () -> Decorator
      #   def on_lavender: () -> Decorator
      #   def on_lavender_blush: () -> Decorator
      #   def on_lawn_green: () -> Decorator
      #   def on_lemon_chiffon: () -> Decorator
      #   def on_light_blue: () -> Decorator
      #   def on_light_coral: () -> Decorator
      #   def on_light_cyan: () -> Decorator
      #   def on_light_cyan1: () -> Decorator
      #   def on_light_cyan3: () -> Decorator
      #   def on_light_goldenrod1: () -> Decorator
      #   def on_light_goldenrod2: () -> Decorator
      #   def on_light_goldenrod2_221: () -> Decorator
      #   def on_light_goldenrod3: () -> Decorator
      #   def on_light_goldenrod_yellow: () -> Decorator
      #   def on_light_gray: () -> Decorator
      #   def on_light_green: () -> Decorator
      #   def on_light_green_120: () -> Decorator
      #   def on_light_pink: () -> Decorator
      #   def on_light_pink1: () -> Decorator
      #   def on_light_pink3: () -> Decorator
      #   def on_light_pink4: () -> Decorator
      #   def on_light_salmon: () -> Decorator
      #   def on_light_salmon1: () -> Decorator
      #   def on_light_salmon3: () -> Decorator
      #   def on_light_salmon3_173: () -> Decorator
      #   def on_light_sea_green: () -> Decorator
      #   def on_light_sky_blue: () -> Decorator
      #   def on_light_sky_blue1: () -> Decorator
      #   def on_light_sky_blue3: () -> Decorator
      #   def on_light_sky_blue3_110: () -> Decorator
      #   def on_light_slate_blue: () -> Decorator
      #   def on_light_slate_gray: () -> Decorator
      #   def on_light_slate_grey: () -> Decorator
      #   def on_light_steel_blue: () -> Decorator
      #   def on_light_steel_blue1: () -> Decorator
      #   def on_light_steel_blue3: () -> Decorator
      #   def on_light_yellow: () -> Decorator
      #   def on_lime: () -> Decorator
      #   def on_lime_green: () -> Decorator
      #   def on_lime_system: () -> Decorator
      #   def on_linen: () -> Decorator
      #   def on_magenta: () -> Decorator
      #   def on_magenta1: () -> Decorator
      #   def on_magenta2: () -> Decorator
      #   def on_magenta2_200: () -> Decorator
      #   def on_magenta3: () -> Decorator
      #   def on_magenta3_163: () -> Decorator
      #   def on_magenta3_164: () -> Decorator
      #   def on_maroon: () -> Decorator
      #   def on_maroon_system: () -> Decorator
      #   def on_medium_aquamarine: () -> Decorator
      #   def on_medium_blue: () -> Decorator
      #   def on_medium_orchid: () -> Decorator
      #   def on_medium_orchid1: () -> Decorator
      #   def on_medium_orchid1_207: () -> Decorator
      #   def on_medium_orchid3: () -> Decorator
      #   def on_medium_purple: () -> Decorator
      #   def on_medium_purple1: () -> Decorator
      #   def on_medium_purple2: () -> Decorator
      #   def on_medium_purple2_140: () -> Decorator
      #   def on_medium_purple3: () -> Decorator
      #   def on_medium_purple3_98: () -> Decorator
      #   def on_medium_purple4: () -> Decorator
      #   def on_medium_sea_green: () -> Decorator
      #   def on_medium_slate_blue: () -> Decorator
      #   def on_medium_spring_green: () -> Decorator
      #   def on_medium_turquoise: () -> Decorator
      #   def on_medium_violet_red: () -> Decorator
      #   def on_midnight_blue: () -> Decorator
      #   def on_mint_cream: () -> Decorator
      #   def on_misty_rose: () -> Decorator
      #   def on_misty_rose1: () -> Decorator
      #   def on_misty_rose3: () -> Decorator
      #   def on_moccasin: () -> Decorator
      #   def on_navajo_white: () -> Decorator
      #   def on_navajo_white1: () -> Decorator
      #   def on_navajo_white3: () -> Decorator
      #   def on_navy: () -> Decorator
      #   def on_navy_blue: () -> Decorator
      #   def on_navy_system: () -> Decorator
      #   def on_old_lace: () -> Decorator
      #   def on_olive: () -> Decorator
      #   def on_olive_drab: () -> Decorator
      #   def on_olive_system: () -> Decorator
      #   def on_orange: () -> Decorator
      #   def on_orange1: () -> Decorator
      #   def on_orange3: () -> Decorator
      #   def on_orange4: () -> Decorator
      #   def on_orange4_94: () -> Decorator
      #   def on_orange_red: () -> Decorator
      #   def on_orange_red1: () -> Decorator
      #   def on_orchid: () -> Decorator
      #   def on_orchid1: () -> Decorator
      #   def on_orchid2: () -> Decorator
      #   def on_pale_goldenrod: () -> Decorator
      #   def on_pale_green: () -> Decorator
      #   def on_pale_green1: () -> Decorator
      #   def on_pale_green1_156: () -> Decorator
      #   def on_pale_green3: () -> Decorator
      #   def on_pale_green3_114: () -> Decorator
      #   def on_pale_turquoise: () -> Decorator
      #   def on_pale_turquoise1: () -> Decorator
      #   def on_pale_turquoise4: () -> Decorator
      #   def on_pale_violet_red: () -> Decorator
      #   def on_pale_violet_red1: () -> Decorator
      #   def on_papaya_whip: () -> Decorator
      #   def on_peach_puff: () -> Decorator
      #   def on_peru: () -> Decorator
      #   def on_pink: () -> Decorator
      #   def on_pink1: () -> Decorator
      #   def on_pink3: () -> Decorator
      #   def on_plum: () -> Decorator
      #   def on_plum1: () -> Decorator
      #   def on_plum2: () -> Decorator
      #   def on_plum3: () -> Decorator
      #   def on_plum4: () -> Decorator
      #   def on_powder_blue: () -> Decorator
      #   def on_purple: () -> Decorator
      #   def on_purple3: () -> Decorator
      #   def on_purple4: () -> Decorator
      #   def on_purple4_55: () -> Decorator
      #   def on_purple_129: () -> Decorator
      #   def on_purple_system: () -> Decorator
      #   def on_red: () -> Decorator
      #   def on_red1: () -> Decorator
      #   def on_red3: () -> Decorator
      #   def on_red3_160: () -> Decorator
      #   def on_red_system: () -> Decorator
      #   def on_rosy_brown: () -> Decorator
      #   def on_royal_blue: () -> Decorator
      #   def on_royal_blue1: () -> Decorator
      #   def on_saddle_brown: () -> Decorator
      #   def on_salmon: () -> Decorator
      #   def on_salmon1: () -> Decorator
      #   def on_sandy_brown: () -> Decorator
      #   def on_sea_green: () -> Decorator
      #   def on_sea_shell: () -> Decorator
      #   def on_sienna: () -> Decorator
      #   def on_silver: () -> Decorator
      #   def on_silver_system: () -> Decorator
      #   def on_sky_blue: () -> Decorator
      #   def on_sky_blue1: () -> Decorator
      #   def on_sky_blue2: () -> Decorator
      #   def on_sky_blue3: () -> Decorator
      #   def on_slate_blue: () -> Decorator
      #   def on_slate_blue1: () -> Decorator
      #   def on_slate_blue3: () -> Decorator
      #   def on_slate_blue3_62: () -> Decorator
      #   def on_slate_gray: () -> Decorator
      #   def on_snow: () -> Decorator
      #   def on_spring_green: () -> Decorator
      #   def on_spring_green1: () -> Decorator
      #   def on_spring_green2: () -> Decorator
      #   def on_spring_green2_47: () -> Decorator
      #   def on_spring_green3: () -> Decorator
      #   def on_spring_green3_41: () -> Decorator
      #   def on_spring_green4: () -> Decorator
      #   def on_steel_blue: () -> Decorator
      #   def on_steel_blue1: () -> Decorator
      #   def on_steel_blue1_81: () -> Decorator
      #   def on_steel_blue3: () -> Decorator
      #   def on_tan: () -> Decorator
      #   def on_teal: () -> Decorator
      #   def on_teal_system: () -> Decorator
      #   def on_thistle: () -> Decorator
      #   def on_thistle1: () -> Decorator
      #   def on_thistle3: () -> Decorator
      #   def on_tomato: () -> Decorator
      #   def on_turquoise: () -> Decorator
      #   def on_turquoise2: () -> Decorator
      #   def on_turquoise4: () -> Decorator
      #   def on_violet: () -> Decorator
      #   def on_wheat: () -> Decorator
      #   def on_wheat1: () -> Decorator
      #   def on_wheat4: () -> Decorator
      #   def on_white: () -> Decorator
      #   def on_white_smoke: () -> Decorator
      #   def on_white_system: () -> Decorator
      #   def on_yellow: () -> Decorator
      #   def on_yellow1: () -> Decorator
      #   def on_yellow2: () -> Decorator
      #   def on_yellow3: () -> Decorator
      #   def on_yellow3_184: () -> Decorator
      #   def on_yellow4: () -> Decorator
      #   def on_yellow4_106: () -> Decorator
      #   def on_yellow_green: () -> Decorator
      #   def on_yellow_system: () -> Decorator
      #   def orange: () -> Decorator
      #   def orange1: () -> Decorator
      #   def orange3: () -> Decorator
      #   def orange4: () -> Decorator
      #   def orange4_94: () -> Decorator
      #   def orange_red: () -> Decorator
      #   def orange_red1: () -> Decorator
      #   def orchid: () -> Decorator
      #   def orchid1: () -> Decorator
      #   def orchid2: () -> Decorator
      #   def pale_goldenrod: () -> Decorator
      #   def pale_green: () -> Decorator
      #   def pale_green1: () -> Decorator
      #   def pale_green1_156: () -> Decorator
      #   def pale_green3: () -> Decorator
      #   def pale_green3_114: () -> Decorator
      #   def pale_turquoise: () -> Decorator
      #   def pale_turquoise1: () -> Decorator
      #   def pale_turquoise4: () -> Decorator
      #   def pale_violet_red: () -> Decorator
      #   def pale_violet_red1: () -> Decorator
      #   def papaya_whip: () -> Decorator
      #   def peach_puff: () -> Decorator
      #   def peru: () -> Decorator
      #   def pink: () -> Decorator
      #   def pink1: () -> Decorator
      #   def pink3: () -> Decorator
      #   def plum: () -> Decorator
      #   def plum1: () -> Decorator
      #   def plum2: () -> Decorator
      #   def plum3: () -> Decorator
      #   def plum4: () -> Decorator
      #   def powder_blue: () -> Decorator
      #   def purple: () -> Decorator
      #   def purple3: () -> Decorator
      #   def purple4: () -> Decorator
      #   def purple4_55: () -> Decorator
      #   def purple_129: () -> Decorator
      #   def purple_system: () -> Decorator
      #   def red: () -> Decorator
      #   def red1: () -> Decorator
      #   def red3: () -> Decorator
      #   def red3_160: () -> Decorator
      #   def red_system: () -> Decorator
      #   def rosy_brown: () -> Decorator
      #   def royal_blue: () -> Decorator
      #   def royal_blue1: () -> Decorator
      #   def saddle_brown: () -> Decorator
      #   def salmon: () -> Decorator
      #   def salmon1: () -> Decorator
      #   def sandy_brown: () -> Decorator
      #   def sea_green: () -> Decorator
      #   def sea_shell: () -> Decorator
      #   def sienna: () -> Decorator
      #   def silver: () -> Decorator
      #   def silver_system: () -> Decorator
      #   def sky_blue: () -> Decorator
      #   def sky_blue1: () -> Decorator
      #   def sky_blue2: () -> Decorator
      #   def sky_blue3: () -> Decorator
      #   def slate_blue: () -> Decorator
      #   def slate_blue1: () -> Decorator
      #   def slate_blue3: () -> Decorator
      #   def slate_blue3_62: () -> Decorator
      #   def slate_gray: () -> Decorator
      #   def snow: () -> Decorator
      #   def spring_green: () -> Decorator
      #   def spring_green1: () -> Decorator
      #   def spring_green2: () -> Decorator
      #   def spring_green2_47: () -> Decorator
      #   def spring_green3: () -> Decorator
      #   def spring_green3_41: () -> Decorator
      #   def spring_green4: () -> Decorator
      #   def steel_blue: () -> Decorator
      #   def steel_blue1: () -> Decorator
      #   def steel_blue1_81: () -> Decorator
      #   def steel_blue3: () -> Decorator
      #   def tan: () -> Decorator
      #   def teal: () -> Decorator
      #   def teal_system: () -> Decorator
      #   def thistle: () -> Decorator
      #   def thistle1: () -> Decorator
      #   def thistle3: () -> Decorator
      #   def tomato: () -> Decorator
      #   def turquoise: () -> Decorator
      #   def turquoise2: () -> Decorator
      #   def turquoise4: () -> Decorator
      #   def violet: () -> Decorator
      #   def wheat: () -> Decorator
      #   def wheat1: () -> Decorator
      #   def wheat4: () -> Decorator
      #   def white: () -> Decorator
      #   def white_smoke: () -> Decorator
      #   def white_system: () -> Decorator
      #   def yellow: () -> Decorator
      #   def yellow1: () -> Decorator
      #   def yellow2: () -> Decorator
      #   def yellow3: () -> Decorator
      #   def yellow3_184: () -> Decorator
      #   def yellow4: () -> Decorator
      #   def yellow4_106: () -> Decorator
      #   def yellow_green: () -> Decorator
      #   def yellow_system: () -> Decorator

      # Install a color method on the {Decorator} class
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since unreleased
      #
      # @api private
      #
      # @param color_name [Symbol] the name of the color to install
      #
      # @return [void]
      # @rbs (Symbol color_name) -> void
      def self.install(color_name)
        { color_name => :foreground, :"on_#{color_name}" => :background }.each do |method_name, style_type|
          # @type var style_type: Sai::Conversion::ColorSequence::style_type
          Sai::Decorator.undef_method(method_name) if Sai::Decorator.method_defined?(method_name)
          Sai::Decorator.define_method(method_name) { apply_named_color(style_type, color_name) }
        end
      end

      Sai::NamedColors.names.each { |color| Sai::Decorator::NamedColors.install(color) }

      private

      # Apply a named color to the specified style type
      #
      # @author {https://aaronmallen.me Aaron Allen}
      # @since 0.1.0
      #
      # @api private
      #
      # @param style_type [Symbol] the style type to apply the color to
      # @param color [Symbol] the color to apply
      #
      # @return [Decorator] a new instance of Decorator with the color applied
      # @rbs (Conversion::ColorSequence::style_type style_type, Symbol color) -> Decorator
      def apply_named_color(style_type, color)
        dup.tap { |duped| duped.instance_variable_set(:"@#{style_type}", color) } #: Decorator
      end
    end
  end
end
