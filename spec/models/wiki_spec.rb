require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { create(:wiki) }

  let(:private) { false }

  #here confirm that a wiki responds to the appropriate attributes
  describe "attributes" do
    it "has title, body, and public attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body)
    end
    # confirm that the public attribute is set to true by default
    it " is not private by default" do
      expect(wiki.private).to be(false)
    end

  end

end
