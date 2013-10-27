require 'git/duet/repo'
require 'git/duet/author'
require 'spec_helper'

describe Git::Duet::Repo do
  subject { described_class.new '~/code/mynewsdesk' }
  let(:home_code_mynewsdesk) { File.join ENV['HOME'], 'code', 'mynewsdesk' }
  before { subject.stub(:raw_duet_config) { config } }

  describe '#authors' do
    it 'extracts the authors from the git config' do
      author_keys = subject.authors.map(&:key)
      expect(author_keys).to eq authors.map(&:key)
    end
  end

  describe '#authors=' do
    it 'sets the authors' do
      subject.authors = authors
      expect(subject.authors.map(&:to_s)).to eq authors.map(&:to_s)
    end
  end

  describe '#email' do
    it 'extracts the base email from the git config' do
      subject.stub(:raw_duet_config) { config }

      subject.email
    end
  end

  describe '#email=' do
    it 'sets the base email' do
      expect(subject).to receive(:group_email=)

      subject.email = config_email
    end
  end
end
