require 'git/duet/pair'
require 'git/duet/repo'
require 'spec_helper'

describe Git::Duet::Pair do
  subject { described_class.new authors }

  describe '#set' do
    before { Git::Duet::Repo.any_instance.stub(:email) { 'dev@mynewsdesk.com' } }

    it 'sets up the pair name' do
      expect(subject).to receive(:set_pair_name) { pair_name }

      subject.set
    end

    it 'sets up pair email' do
      expect(subject).to receive(:set_pair_email) { pair_email }

      subject.set
    end

    it 'displays the current committer' do
      subject.stub(:set_pair_name) { pair_name }
      subject.stub(:current_committer) { pair_email }

      expect(subject.set).to eq 'David Billskog and Teo Ljungberg <dev+billskog+teo@mynewsdesk.com>'
    end
  end
end
