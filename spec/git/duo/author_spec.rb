require 'spec_helper'
require 'git/duo/author'

describe Git::Duo::Author do
  subject { described_class.new 'Teo Ljungberg <teo.ljungberg@mynewsdesk.com>', 'teo' }

  describe '.import' do
    subject { described_class.import 'teo Teo Ljungberg <teo.ljungberg@mynewsdesk.com>' }

    it 'creates an author from the raw input' do
      expect(subject.key).to eq 'teo'
      expect(subject.name).to eq 'Teo Ljungberg'
      expect(subject.email).to eq 'teo.ljungberg@mynewsdesk.com'
    end
  end

  describe '#name' do
    it 'extracts name' do
      expect(subject.name).to eq 'Teo Ljungberg'
    end
  end

  describe '#email' do
    it 'extracts email' do
      expect(subject.email).to eq 'teo.ljungberg@mynewsdesk.com'
    end
  end

  describe '#key' do
    it 'sets from input' do
      expect(subject.key).to eq 'teo'
    end

    it 'can be overridden' do
      expect {
        subject.key = 'billskog'
      }.to change { subject.key }.from 'teo'
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the author' do
      expect(subject.to_s).to eq 'teo Teo Ljungberg <teo.ljungberg@mynewsdesk.com>'
    end
  end
end
