require 'git/duet/pair'
require 'spec_helper'

describe Git::Duet::Pair do
  subject { described_class.new authors }

  describe '#set' do
    it 'sets up the pair names' do
      expect(subject.set).to eq 'Teo Ljungberg and David Billskog <dev+billskog+teo@mynewsdesk.com>'
    end
  end
end
