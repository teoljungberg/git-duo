require 'git/duet/repo'
require 'git/duet/author'
require 'spec_helper'

describe Git::Duet::Repo do
  subject { described_class.new '~/code/mynewsdesk' }
  let(:home_code_mynewsdesk) { File.join ENV['HOME'], 'code', 'mynewsdesk' }

  describe '#authors' do
    it 'extracts the authors from the git config' do
      subject.stub(:raw_duet_config) { config }

      subject.authors
    end
  end

  describe '#authors=' do
    let(:sample_author) { config_authors.sample }

    it 'sets the authors' do
      expect(subject).to receive(:author=).exactly(config_authors.size).times
      expect(Git::Duet::Author).to receive(:import).exactly(config_authors.size).times

      subject.authors = config_authors
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
