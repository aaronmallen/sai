# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sai::Decorator do
  describe '.new' do
    subject(:decorator) { described_class.new(mode: mode) }

    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }

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

  describe '#darken_background' do
    subject(:darken_background) { decorator.darken_background(amount) }

    let(:decorator) { described_class.new(mode: mode).on_rgb(0, 0, 238) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
    let(:amount) { 0.5 }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(darken_background).not_to eq(decorator)
    end

    it 'is expected to set the darkened background color on the new instance' do
      rgb = [0, 0, 238].map { |c| (c * 0.5).round }
      expect(darken_background.instance_variable_get(:@background)).to eq(rgb)
    end

    it 'is expected not to modify the original instance' do
      original_background = decorator.instance_variable_get(:@background)
      darken_background
      expect(decorator.instance_variable_get(:@background)).to eq(original_background)
    end

    context 'when given an invalid amount' do
      context 'when amount is negative' do
        let(:amount) { -0.5 }

        it 'is expected to raise ArgumentError' do
          expect { darken_background }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end

      context 'when amount is greater than 1.0' do
        let(:amount) { 1.5 }

        it 'is expected to raise ArgumentError' do
          expect { darken_background }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end
    end
  end

  describe '#darken_text' do
    subject(:darken_text) { decorator.darken_text(amount) }

    let(:decorator) { described_class.new(mode: mode).rgb(205, 0, 0) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
    let(:amount) { 0.5 }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(darken_text).not_to eq(decorator)
    end

    it 'is expected to set the darkened foreground color on the new instance' do
      rgb = [205, 0, 0].map { |c| (c * 0.5).round }
      expect(darken_text.instance_variable_get(:@foreground)).to eq(rgb)
    end

    it 'is expected not to modify the original instance' do
      original_foreground = decorator.instance_variable_get(:@foreground)
      darken_text
      expect(decorator.instance_variable_get(:@foreground)).to eq(original_foreground)
    end

    context 'when given an invalid amount' do
      context 'when amount is negative' do
        let(:amount) { -0.5 }

        it 'is expected to raise ArgumentError' do
          expect { darken_text }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end

      context 'when amount is greater than 1.0' do
        let(:amount) { 1.5 }

        it 'is expected to raise ArgumentError' do
          expect { darken_text }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end
    end
  end

  describe '#decorate' do
    subject(:decorated_text) { decorator.decorate(text) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
    let(:text) { 'Hello, world!' }

    context 'when no styles or colors are applied' do
      it 'is expected to return the original text' do
        expect(decorated_text).to eq(text)
      end
    end

    context 'when a foreground color is applied' do
      let(:decorated) { decorator.rgb(205, 0, 0) }

      it 'is expected to wrap the text with the color sequence and reset' do
        expect(decorated.decorate(text)).to eq("\e[38;2;205;0;0m#{text}\e[0m")
      end
    end

    context 'when a background color is applied' do
      let(:decorated) { decorator.on_rgb(0, 0, 238) }

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
      let(:decorated) { decorator.rgb(205, 0, 0).on_rgb(0, 0, 238).bold }

      it 'is expected to apply all decorations in order' do
        expect(decorated.decorate(text)).to eq("\e[38;2;205;0;0m\e[48;2;0;0;238m\e[1m#{text}\e[0m")
      end
    end
  end

  describe '#gradient' do
    subject(:gradient_decorator) { decorator.gradient(start_rgb, end_rgb, steps) }

    let(:decorator) { described_class.new(mode: Sai::ModeSelector::TWENTY_FOUR_BIT) }
    let(:start_rgb) { [205, 0, 0] }
    let(:end_rgb) { [0, 0, 238] }
    let(:steps) { 3 }
    let(:text) { 'RGB' }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(gradient_decorator).not_to eq(decorator)
    end

    it 'is expected to set the foreground sequence on the new instance' do
      expect(gradient_decorator.instance_variable_get(:@foreground_sequence)).to be_an(Array)
    end

    it 'is expected to create a gradient with the specified number of colors' do
      sequence = gradient_decorator.instance_variable_get(:@foreground_sequence)
      expect(sequence.length).to eq(steps)
    end

    it 'is expected to apply the gradient to text' do
      result = gradient_decorator.decorate(text).to_s
      expect(result).to match(/\e\[38;2;\d+;\d+;\d+mR\e\[0m\e\[38;2;\d+;\d+;\d+mG\e\[0m\e\[38;2;\d+;\d+;\d+mB\e\[0m/)
    end

    context 'when given invalid steps' do
      let(:steps) { 1 }

      it 'is expected to raise ArgumentError' do
        expect { gradient_decorator }.to raise_error(ArgumentError, /Steps must be at least 2/)
      end
    end
  end

  describe '#hex' do
    subject(:hex_decorator) { decorator.hex(code) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }

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

  describe '#lighten_background' do
    subject(:lighten_background) { decorator.lighten_background(amount) }

    let(:decorator) { described_class.new(mode: mode).on_rgb(205, 0, 0) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
    let(:amount) { 0.5 }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(lighten_background).not_to eq(decorator)
    end

    it 'is expected to set the lightened background color on the new instance' do
      rgb = [205, 0, 0].map { |c| [255, (c * 1.5).round].min }
      expect(lighten_background.instance_variable_get(:@background)).to eq(rgb)
    end

    it 'is expected not to modify the original instance' do
      original_background = decorator.instance_variable_get(:@background)
      lighten_background
      expect(decorator.instance_variable_get(:@background)).to eq(original_background)
    end

    context 'when given an invalid amount' do
      context 'when amount is negative' do
        let(:amount) { -0.5 }

        it 'is expected to raise ArgumentError' do
          expect { lighten_background }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end

      context 'when amount is greater than 1.0' do
        let(:amount) { 1.5 }

        it 'is expected to raise ArgumentError' do
          expect { lighten_background }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end
    end
  end

  describe '#lighten_text' do
    subject(:lighten_text) { decorator.lighten_text(amount) }

    let(:decorator) { described_class.new(mode: mode).rgb(0, 0, 238) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
    let(:amount) { 0.5 }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(lighten_text).not_to eq(decorator)
    end

    it 'is expected to set the lightened foreground color on the new instance' do
      rgb = [0, 0, 238].map { |c| [255, (c * 1.5).round].min }
      expect(lighten_text.instance_variable_get(:@foreground)).to eq(rgb)
    end

    it 'is expected not to modify the original instance' do
      original_foreground = decorator.instance_variable_get(:@foreground)
      lighten_text
      expect(decorator.instance_variable_get(:@foreground)).to eq(original_foreground)
    end

    context 'when given an invalid amount' do
      context 'when amount is negative' do
        let(:amount) { -0.5 }

        it 'is expected to raise ArgumentError' do
          expect { lighten_text }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end

      context 'when amount is greater than 1.0' do
        let(:amount) { 1.5 }

        it 'is expected to raise ArgumentError' do
          expect { lighten_text }.to raise_error(ArgumentError, /Invalid percentage/)
        end
      end
    end
  end

  describe '#on_gradient' do
    subject(:on_gradient_decorator) { decorator.on_gradient(start_rgb, end_rgb, steps) }

    let(:decorator) { described_class.new(mode: Sai::ModeSelector::TWENTY_FOUR_BIT) }
    let(:start_rgb) { [205, 0, 0] }
    let(:end_rgb) { [0, 0, 238] }
    let(:steps) { 3 }
    let(:text) { 'RGB' }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(on_gradient_decorator).not_to eq(decorator)
    end

    it 'is expected to set the background sequence on the new instance' do
      expect(on_gradient_decorator.instance_variable_get(:@background_sequence)).to be_an(Array)
    end

    it 'is expected to create a gradient with the specified number of colors' do
      sequence = on_gradient_decorator.instance_variable_get(:@background_sequence)
      expect(sequence.length).to eq(steps)
    end

    it 'is expected to apply the gradient to text' do
      result = on_gradient_decorator.decorate(text).to_s
      expect(result).to match(/\e\[48;2;\d+;\d+;\d+mR\e\[0m\e\[48;2;\d+;\d+;\d+mG\e\[0m\e\[48;2;\d+;\d+;\d+mB\e\[0m/)
    end

    context 'when given invalid steps' do
      let(:steps) { 1 }

      it 'is expected to raise ArgumentError' do
        expect { on_gradient_decorator }.to raise_error(ArgumentError, /Steps must be at least 2/)
      end
    end
  end

  describe '#on_hex' do
    subject(:on_hex_decorator) { decorator.on_hex(code) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }

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
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
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

  describe '#on_rainbow' do
    subject(:on_rainbow_decorator) { decorator.on_rainbow(steps) }

    let(:decorator) { described_class.new(mode: Sai::ModeSelector::TWENTY_FOUR_BIT) }
    let(:steps) { 6 }
    let(:text) { 'RAINBOW' }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(on_rainbow_decorator).not_to eq(decorator)
    end

    it 'is expected to set the background sequence on the new instance' do
      expect(on_rainbow_decorator.instance_variable_get(:@background_sequence)).to be_an(Array)
    end

    it 'is expected to create a sequence with the specified number of colors' do
      sequence = on_rainbow_decorator.instance_variable_get(:@background_sequence)
      expect(sequence.length).to eq(steps)
    end

    it 'is expected to apply rainbow colors to text' do
      result = on_rainbow_decorator.decorate(text).to_s
      expect(result).to match(/(\e\[48;2;\d+;\d+;\d+m[A-Z]\e\[0m){6}/)
    end

    context 'when given invalid steps' do
      let(:steps) { 1 }

      it 'is expected to raise ArgumentError' do
        expect { on_rainbow_decorator }.to raise_error(ArgumentError, /Steps must be at least 2/)
      end
    end
  end

  describe '#on_rgb' do
    subject(:on_rgb_decorator) { decorator.on_rgb(red, green, blue) }

    let(:decorator) { described_class.new(mode: mode) }
    let(:mode) { Sai::ModeSelector::TWENTY_FOUR_BIT }
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

  describe '#rainbow' do
    subject(:rainbow_decorator) { decorator.rainbow(steps) }

    let(:decorator) { described_class.new(mode: Sai::ModeSelector::TWENTY_FOUR_BIT) }
    let(:steps) { 6 }
    let(:text) { 'RAINBOW' }

    it { is_expected.to be_an_instance_of(described_class) }

    it 'is expected to return a new instance' do
      expect(rainbow_decorator).not_to eq(decorator)
    end

    it 'is expected to set the foreground sequence on the new instance' do
      expect(rainbow_decorator.instance_variable_get(:@foreground_sequence)).to be_an(Array)
    end

    it 'is expected to create a sequence with the specified number of colors' do
      sequence = rainbow_decorator.instance_variable_get(:@foreground_sequence)
      expect(sequence.length).to eq(steps)
    end

    it 'is expected to apply rainbow colors to text' do
      result = rainbow_decorator.decorate(text).to_s
      expect(result).to match(/(\e\[38;2;\d+;\d+;\d+m[A-Z]\e\[0m){6}/)
    end

    context 'when given invalid steps' do
      let(:steps) { 1 }

      it 'is expected to raise ArgumentError' do
        expect { rainbow_decorator }.to raise_error(ArgumentError, /Steps must be at least 2/)
      end
    end
  end

  describe '#with_mode' do
    subject(:with_mode) { decorator.with_mode(color_mode) }

    let(:decorator) { described_class.new(mode: Sai.mode.true_color) }
    let(:color_mode) { Sai.mode.no_color }

    it 'is expected to set the color mode' do
      before_mode_set = decorator.hex('#CD0000').decorate('text')
      after_mode_set = with_mode.decorate('text')

      expect(after_mode_set).not_to eq(before_mode_set)
    end
  end

  describe 'color mode behavior' do
    subject(:decorated_text) { decorator.hex('#CD0000').decorate('test') }

    let(:decorator) { described_class.new(mode: Sai.mode.auto) }

    before do
      Sai::ModeSelector.instance_variable_set(:@supported_color_mode, nil)
      allow(Sai::ModeSelector).to receive(:supported_color_mode).and_return(terminal_support)
    end

    context 'when terminal supports true color' do
      let(:terminal_support) { Sai::ModeSelector::TWENTY_FOUR_BIT }

      it 'is expected to use true color codes' do
        expect(decorated_text).to eq("\e[38;2;205;0;0mtest\e[0m")
      end
    end

    context 'when terminal supports 8-bit color' do
      let(:terminal_support) { Sai::ModeSelector::EIGHT_BIT }

      it 'is expected to use 8-bit color codes' do
        expect(decorated_text).to eq("\e[38;5;160mtest\e[0m")
      end
    end

    context 'when terminal supports 4-bit color' do
      let(:terminal_support) { Sai::ModeSelector::FOUR_BIT }

      it 'is expected to use 4-bit color codes' do
        expect(decorated_text).to eq("\e[31mtest\e[0m")
      end
    end

    context 'when terminal supports only basic color' do
      let(:terminal_support) { Sai::ModeSelector::THREE_BIT }

      it 'is expected to use basic color codes' do
        expect(decorated_text).to eq("\e[31mtest\e[0m")
      end
    end

    context 'when terminal has no color support' do
      let(:terminal_support) { Sai::ModeSelector::NO_COLOR }

      it 'is expected to return unmodified text' do
        expect(decorated_text).to eq('test')
      end
    end
  end

  describe 'color registration' do
    subject(:register_color) { Sai::Registry.register(color_name, color_value) }

    let(:color_name) { :test_color }
    let(:color_value) { [255, 0, 0] }
    let(:decorator) { described_class.new(mode: Sai::ModeSelector::TWENTY_FOUR_BIT) }
    let(:text) { 'test' }

    after do
      described_class.send(:remove_method, color_name) if described_class.method_defined?(color_name)
      described_class.send(:remove_method, :"on_#{color_name}") if described_class.method_defined?(:"on_#{color_name}")
    end

    it 'is expected to define a foreground color method' do
      register_color
      expect(decorator).to respond_to(color_name)
    end

    it 'is expected to define a background color method' do
      register_color
      expect(decorator).to respond_to(:"on_#{color_name}")
    end

    it 'is expected to apply the color as foreground' do
      register_color
      result = decorator.public_send(color_name).decorate(text)
      expect(result).to eq("\e[38;2;255;0;0m#{text}\e[0m")
    end

    it 'is expected to apply the color as background' do
      register_color
      result = decorator.public_send(:"on_#{color_name}").decorate(text)
      expect(result).to eq("\e[48;2;255;0;0m#{text}\e[0m")
    end

    context 'when registering multiple colors' do
      let(:colors) do
        {
          test_blue: [0, 0, 255],
          test_green: [0, 255, 0]
        }
      end

      before do
        colors.each { |name, value| Sai::Registry.register(name, value) }
      end

      after do
        colors.each_key do |name|
          described_class.send(:remove_method, name) if described_class.method_defined?(name)
          described_class.send(:remove_method, :"on_#{name}") if described_class.method_defined?(:"on_#{name}")
        end
      end

      it 'is expected to create all color methods' do
        colors.each_key do |name|
          expect(decorator).to respond_to(name).and(respond_to(:"on_#{name}"))
        end
      end
    end
  end
end
