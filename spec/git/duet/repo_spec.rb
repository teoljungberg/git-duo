require 'git/duet/repo'
require 'git/duet/author'
require 'git/duet/wrapper'
require 'spec_helper'

describe Git::Duet::Repo do
  subject { described_class.new '~/code/mynewsdesk' }

  describe '#new' do
    it 'expands the given path' do
      expect(subject.repo).to eq home_code_mynewsdesk
    end
  end

  describe '#authors' do
    it 'filters the authors from the rest of the config' do
      expect(subject).to receive(:config) { config }
      expect(subject).to receive(:filter_authors).with(config) { config_authors }
      subject.authors
    end
  end

  describe '#authors=' do
    let(:sample_author) { config_authors.sample }

    it 'sets the authors' do
      expect(Git::Duet::Wrapper).to receive(:author=).exactly(config_authors.size).times
      expect(Git::Duet::Author).to receive(:import).exactly(config_authors.size).times
      subject.authors = config_authors
    end
  end

  describe '#email' do
    it 'filters the email from the rest of the config' do
      expect(subject).to receive(:config) { config }
      expect(subject).to receive(:filter_email).with(config) { config_email }
      subject.email
    end
  end

  describe '#email=' do
    let(:sample_email) { config_email.sample }

    it 'sets the authors' do
      expect(Git::Duet::Wrapper).to receive(:email=).exactly(config_email.size).times
      subject.email = config_email
    end
  end
end

def home_code_mynewsdesk
  File.join ENV['HOME'], 'code', 'mynewsdesk'
end
