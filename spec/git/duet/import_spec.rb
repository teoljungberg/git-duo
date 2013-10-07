require 'spec_helper'
require 'git/duet/import'
require 'git/duet/wrapper'

describe Git::Duet::Import do
  let(:import) { described_class.new config }
  let(:number_of_authors) { 2 }

  describe '#email_pattern' do
    it 'imports the email pattern' do
      expect(Git::Duet::Wrapper).to receive(:email=)
      import.email_pattern
    end
  end

  describe '#authors' do
    it 'imports the authors' do
      expect(Git::Duet::Wrapper).to receive(:author=).exactly(number_of_authors).times
      import.authors
    end
  end
end
