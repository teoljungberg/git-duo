require 'git/duet/repo'
require 'git/duet/author'
require 'spec_helper'

describe Git::Duet::Repo do
  subject { described_class.new '~/code/mynewsdesk' }
  let(:home_code_mynewsdesk) { File.join ENV['HOME'], 'code', 'mynewsdesk' }

  describe '#new' do
    it 'expands the given path' do
      expect(subject.repo).to eq home_code_mynewsdesk
    end
  end

  describe '#authors' do
    it 'filters the authors from the rest of the config' do
      subject.stub(:raw_duet_config) { config }
      expect(subject).to receive(:filter_authors).with(config) { config_authors }
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
    it 'filters the email from the rest of the config' do
      subject.stub(:raw_duet_config) { config }
      expect(subject).to receive(:filter_email).with(config) { config_email }
      subject.email
    end
  end

  describe '#email=' do
    it 'sets the authors' do
      expect(subject).to receive(:group_email=)

      subject.email = config_email
    end
  end
end
