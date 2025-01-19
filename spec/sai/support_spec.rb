# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sai::Support do
  subject(:support) { described_class.new(color_mode) }

  describe '#ansi?' do
    context 'when color mode is NO_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::NO_COLOR }

      it { expect(support.ansi?).to be false }
    end

    context 'when color mode is BASIC' do
      let(:color_mode) { Sai::Terminal::ColorMode::BASIC }

      it { expect(support.ansi?).to be false }
    end

    context 'when color mode is ANSI' do
      let(:color_mode) { Sai::Terminal::ColorMode::ANSI }

      it { expect(support.ansi?).to be true }
    end

    context 'when color mode is ADVANCED' do
      let(:color_mode) { Sai::Terminal::ColorMode::ADVANCED }

      it { expect(support.ansi?).to be true }
    end

    context 'when color mode is TRUE_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { expect(support.ansi?).to be true }
    end
  end

  describe '#basic?' do
    context 'when color mode is NO_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::NO_COLOR }

      it { expect(support.basic?).to be false }
    end

    context 'when color mode is BASIC' do
      let(:color_mode) { Sai::Terminal::ColorMode::BASIC }

      it { expect(support.basic?).to be true }
    end

    context 'when color mode is ANSI' do
      let(:color_mode) { Sai::Terminal::ColorMode::ANSI }

      it { expect(support.basic?).to be true }
    end

    context 'when color mode is ADVANCED' do
      let(:color_mode) { Sai::Terminal::ColorMode::ADVANCED }

      it { expect(support.basic?).to be true }
    end

    context 'when color mode is TRUE_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { expect(support.basic?).to be true }
    end
  end

  describe '#advanced?' do
    context 'when color mode is NO_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::NO_COLOR }

      it { expect(support.advanced?).to be false }
    end

    context 'when color mode is BASIC' do
      let(:color_mode) { Sai::Terminal::ColorMode::BASIC }

      it { expect(support.advanced?).to be false }
    end

    context 'when color mode is ANSI' do
      let(:color_mode) { Sai::Terminal::ColorMode::ANSI }

      it { expect(support.advanced?).to be false }
    end

    context 'when color mode is ADVANCED' do
      let(:color_mode) { Sai::Terminal::ColorMode::ADVANCED }

      it { expect(support.advanced?).to be true }
    end

    context 'when color mode is TRUE_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { expect(support.advanced?).to be true }
    end
  end

  describe '#color?' do
    context 'when color mode is NO_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::NO_COLOR }

      it { expect(support.color?).to be false }
    end

    context 'when color mode is BASIC' do
      let(:color_mode) { Sai::Terminal::ColorMode::BASIC }

      it { expect(support.color?).to be true }
    end

    context 'when color mode is ANSI' do
      let(:color_mode) { Sai::Terminal::ColorMode::ANSI }

      it { expect(support.color?).to be true }
    end

    context 'when color mode is ADVANCED' do
      let(:color_mode) { Sai::Terminal::ColorMode::ADVANCED }

      it { expect(support.color?).to be true }
    end

    context 'when color mode is TRUE_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { expect(support.color?).to be true }
    end
  end

  describe '#true_color?' do
    context 'when color mode is NO_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::NO_COLOR }

      it { expect(support.true_color?).to be false }
    end

    context 'when color mode is BASIC' do
      let(:color_mode) { Sai::Terminal::ColorMode::BASIC }

      it { expect(support.true_color?).to be false }
    end

    context 'when color mode is ANSI' do
      let(:color_mode) { Sai::Terminal::ColorMode::ANSI }

      it { expect(support.true_color?).to be false }
    end

    context 'when color mode is ADVANCED' do
      let(:color_mode) { Sai::Terminal::ColorMode::ADVANCED }

      it { expect(support.true_color?).to be false }
    end

    context 'when color mode is TRUE_COLOR' do
      let(:color_mode) { Sai::Terminal::ColorMode::TRUE_COLOR }

      it { expect(support.true_color?).to be true }
    end
  end
end
