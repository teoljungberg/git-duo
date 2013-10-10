require 'spec_helper'
require 'git/duet/author'

describe Git::Duet::Author do
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
end
