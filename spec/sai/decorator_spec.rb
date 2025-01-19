# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sai::Decorator do
  describe '.new' do
    subject(:decorator) { described_class.new(mode: mode) }

    let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

    it 'is expected to initialize with empty styles' do
      expect(decorator.instance_variable_get(:@styles)).to eq([])
    end

    it 'is expected to initialize with nil foreground' do
      expect(decorator.instance_variable_get(:@foreground)).to be_nil
    end

    it 'is expected to initialize with nil background' do
      expect(decorator.instance_variable_get(:@background)).to be_nil
    end

    it 'is expected to initialize with the provided mode' do
      expect(decorator.instance_variable_get(:@mode)).to eq(mode)
    end
  end

  describe '#decorate' do
    subject(:decorated_text) { decorator.decorate(text) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }
    let(:text) { 'Hello, world!' }

    context 'when no styles or colors are applied' do
      it 'is expected to return the original text' do
        expect(decorated_text).to eq(text)
      end
    end

    context 'when a foreground color is applied' do
      let(:decorated) { decorator.red }

      it 'is expected to wrap the text with the color sequence and reset' do
        expect(decorated.decorate(text)).to eq("\e[38;2;205;0;0m#{text}\e[0m")
      end
    end

    context 'when a background color is applied' do
      let(:decorated) { decorator.on_blue }

      it 'is expected to wrap the text with the color sequence and reset' do
        expect(decorated.decorate(text)).to eq("\e[48;2;0;0;238m#{text}\e[0m")
      end
    end

    context 'when styles are applied' do
      let(:decorated) { decorator.bold }

      it 'is expected to wrap the text with the style sequence and reset' do
        expect(decorated.decorate(text)).to eq("\e[1m#{text}\e[0m")
      end
    end

    context 'when multiple decorations are applied' do
      let(:decorated) { decorator.red.on_blue.bold }

      it 'is expected to apply all decorations in order' do
        expect(decorated.decorate(text)).to eq("\e[38;2;205;0;0m\e[48;2;0;0;238m\e[1m#{text}\e[0m")
      end
    end
  end

  describe '#hex' do
    subject(:hex_decorator) { decorator.hex(code) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

    context 'when given a valid hex code' do
      let(:code) { '#EB4133' }

      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(hex_decorator).not_to eq(decorator)
      end

      it 'is expected to set the foreground color on the new instance' do
        expect(hex_decorator.instance_variable_get(:@foreground)).to eq(code)
      end

      it 'is expected not to modify the original instance' do
        original_foreground = decorator.instance_variable_get(:@foreground)
        hex_decorator
        expect(decorator.instance_variable_get(:@foreground)).to eq(original_foreground)
      end
    end

    context 'when given an invalid hex code' do
      let(:code) { 'invalid' }

      it 'is expected to raise an ArgumentError' do
        expect { hex_decorator }.to raise_error(ArgumentError, 'Invalid hex color code: invalid')
      end
    end
  end

  describe '#on_hex' do
    subject(:on_hex_decorator) { decorator.on_hex(code) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

    context 'when given a valid hex code' do
      let(:code) { '#EB4133' }

      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(on_hex_decorator).not_to eq(decorator)
      end

      it 'is expected to set the background color on the new instance' do
        expect(on_hex_decorator.instance_variable_get(:@background)).to eq(code)
      end

      it 'is expected not to modify the original instance' do
        original_background = decorator.instance_variable_get(:@background)
        on_hex_decorator
        expect(decorator.instance_variable_get(:@background)).to eq(original_background)
      end
    end

    context 'when given an invalid hex code' do
      let(:code) { 'invalid' }

      it 'is expected to raise an ArgumentError' do
        expect { on_hex_decorator }.to raise_error(ArgumentError, 'Invalid hex color code: invalid')
      end
    end
  end

  describe '#rgb' do
    subject(:rgb_decorator) { decorator.rgb(red, green, blue) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }
    let(:red) { 235 }
    let(:green) { 65 }
    let(:blue) { 51 }

    context 'when given valid RGB values' do
      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(rgb_decorator).not_to eq(decorator)
      end

      it 'is expected to set the foreground color on the new instance' do
        expect(rgb_decorator.instance_variable_get(:@foreground)).to eq([red, green, blue])
      end

      it 'is expected not to modify the original instance' do
        original_foreground = decorator.instance_variable_get(:@foreground)
        rgb_decorator
        expect(decorator.instance_variable_get(:@foreground)).to eq(original_foreground)
      end
    end

    context 'when given invalid RGB values' do
      let(:red) { 300 }

      it 'is expected to raise an ArgumentError' do
        expect { rgb_decorator }.to raise_error(ArgumentError, 'Invalid RGB value: 300, 65, 51')
      end
    end
  end

  describe '#on_rgb' do
    subject(:on_rgb_decorator) { decorator.on_rgb(red, green, blue) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }
    let(:red) { 235 }
    let(:green) { 65 }
    let(:blue) { 51 }

    context 'when given valid RGB values' do
      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(on_rgb_decorator).not_to eq(decorator)
      end

      it 'is expected to set the background color on the new instance' do
        expect(on_rgb_decorator.instance_variable_get(:@background)).to eq([red, green, blue])
      end

      it 'is expected not to modify the original instance' do
        original_background = decorator.instance_variable_get(:@background)
        on_rgb_decorator
        expect(decorator.instance_variable_get(:@background)).to eq(original_background)
      end
    end

    context 'when given invalid RGB values' do
      let(:red) { 300 }

      it 'is expected to raise an ArgumentError' do
        expect { on_rgb_decorator }.to raise_error(ArgumentError, 'Invalid RGB value: 300, 65, 51')
      end
    end
  end

  describe 'color mode behavior' do
    subject(:decorated_text) { decorator.hex('#CD0000').decorate('test') }

    let(:decorator) { described_class.new(mode: Sai.mode.auto) }

    before do
      allow(Sai::Terminal::Capabilities).to receive(:detect_color_support).and_return(terminal_support)
    end

    context 'when terminal supports true color' do
      let(:terminal_support) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it 'is expected to use true color codes' do
        expect(decorated_text).to eq("\e[38;2;205;0;0mtest\e[0m")
      end
    end

    context 'when terminal supports 8-bit color' do
      let(:terminal_support) { Sai::Terminal::ColorMode::ADVANCED }

      it 'is expected to use 8-bit color codes' do
        expect(decorated_text).to eq("\e[38;5;160mtest\e[0m")
      end
    end

    context 'when terminal supports 4-bit color' do
      let(:terminal_support) { Sai::Terminal::ColorMode::ANSI }

      it 'is expected to use 4-bit color codes' do
        expect(decorated_text).to eq("\e[31mtest\e[0m")
      end
    end

    context 'when terminal supports only basic color' do
      let(:terminal_support) { Sai::Terminal::ColorMode::BASIC }

      it 'is expected to use basic color codes' do
        expect(decorated_text).to eq("\e[31mtest\e[0m")
      end
    end

    context 'when terminal has no color support' do
      let(:terminal_support) { Sai::Terminal::ColorMode::NO_COLOR }

      it 'is expected to return unmodified text' do
        expect(decorated_text).to eq('test')
      end
    end
  end

  # Test each named color method
  Sai::ANSI::COLOR_NAMES.each_key do |color|
    describe "##{color}" do
      subject(:color_decorator) { decorator.public_send(color) }

      let(:decorator) { described_class.new(mode: mode) }
      let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(color_decorator).not_to eq(decorator)
      end

      it 'is expected to set the foreground color on the new instance' do
        expect(color_decorator.instance_variable_get(:@foreground)).to eq(color)
      end

      it 'is expected not to modify the original instance' do
        original_foreground = decorator.instance_variable_get(:@foreground)
        color_decorator
        expect(decorator.instance_variable_get(:@foreground)).to eq(original_foreground)
      end
    end

    describe "#on_#{color}" do
      subject(:background_color_decorator) { decorator.public_send(:"on_#{color}") }

      let(:decorator) { described_class.new(mode: mode) }
      let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(background_color_decorator).not_to eq(decorator)
      end

      it 'is expected to set the background color on the new instance' do
        expect(background_color_decorator.instance_variable_get(:@background)).to eq(color)
      end

      it 'is expected not to modify the original instance' do
        original_background = decorator.instance_variable_get(:@background)
        background_color_decorator
        expect(decorator.instance_variable_get(:@background)).to eq(original_background)
      end
    end
  end

  # Test each style method
  Sai::ANSI::STYLES.each_key do |style|
    describe "##{style}" do
      subject(:style_decorator) { decorator.public_send(style) }

      let(:decorator) { described_class.new(mode: mode) }
      let(:mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { is_expected.to be_an_instance_of(described_class) }

      it 'is expected to return a new instance' do
        expect(style_decorator).not_to eq(decorator)
      end

      it 'is expected to add the style to the new instance' do
        expect(style_decorator.instance_variable_get(:@styles)).to include(style)
      end

      it 'is expected not to modify the original instance' do
        expect { style_decorator }.not_to(change do
          decorator.instance_variable_get(:@styles).dup
        end)
      end

      it 'is expected not to duplicate styles in the new instance' do
        duplicated_style = style_decorator.public_send(style)
        styles = duplicated_style.instance_variable_get(:@styles)
        expect(styles.count(style)).to eq(1)
      end
    end
  end
end
