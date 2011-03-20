require 'spec_helper'

describe "exemplifies/index.html.erb" do
  before(:each) do
    assign(:exemplifies, [
      stub_model(Exemplify,
        :manifestation_id => 1,
        :item_id => 1
      ),
      stub_model(Exemplify,
        :manifestation_id => 1,
        :item_id => 2
      )
    ])
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders a list of exemplifies" do
    pending("pagination") do
      render
      # Run the generator again with the --webrat flag if you want to use webrat matchers
      assert_select "tr>td", :text => Manifestation.find(1).original_title, :count => 2
    end
  end
end
