require('spec_helper')

describe(Venue) do
  it {should have_and_belong_to_many(:bands)}
end

describe(Venue) do
  it("validates presence of venue") do
    venue = Venue.new({:title => ""})
    expect(venue.save()).to(eq(false))
  end
end
