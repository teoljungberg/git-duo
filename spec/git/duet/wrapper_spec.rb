require 'git/duet/wrapper'
require 'spec_helper'

describe Git::Duet::Wrapper do
  subject { described_class }

  describe '.user_email' do
    it "gets the users' email" do
      expect(subject.user_email).to eq author.email
    end
  end

  describe '.user_email=' do
    it "sets the users' email" do
      expect(subject).to receive(:user_email) { 'david.billskog@mynewsdesk.com' }

      expect {
        subject.user_email = 'david.billskog@mynewsdesk.com'
      }.to change { subject.user_email }
    end
  end

  describe '.user_name' do
    it "gets the users' name" do
      expect(subject.user_name).to eq author.name
    end
  end

  describe '.user_name=' do
    it "sets the users' name" do
      expect(subject).to receive(:user_name) { 'David Billskog' }

      expect {
        subject.user_name = 'David Billskog'
      }.to change { subject.user_name }
    end
  end

  describe '.current_committer' do
    it 'gets the current committer from the local git-config' do
      expect(subject).to receive(:user_name) { 'David Billskog and Teo Ljungberg' }
      expect(subject).to receive(:user_email) { 'dev+billskog+teo@mynewsdesk.com' }

      expect(subject.current_committer).to eq 'David Billskog and Teo Ljungberg <dev+billskog+teo@mynewsdesk.com>'
    end

    it 'gets the current committer from the global git-config' do
      expect(subject).to receive(:user_name) { 'Teo Ljungberg' }
      expect(subject).to receive(:user_email) { 'teo.ljungberg@gmail.com' }

      expect(subject.current_committer).to eq 'Teo Ljungberg <teo.ljungberg@gmail.com>'
    end
  end

  describe '.unpair!' do
    it 'removes the local user git-config' do
      expect(subject).to receive(:current_committer) { 'Teo Ljungberg <teo.ljungberg@gmail.com>' }
      subject.unpair!
    end
  end

  describe '.author' do
    it 'gets the author' do
      expect(subject.author).to eq author
    end
  end

  describe '.author=' do
    it 'sets the author' do
      expect(subject).to receive(:author) { authors.first }

      expect {
        subject.author = authors.first
      }.to change { subject.author }
    end
  end
end
