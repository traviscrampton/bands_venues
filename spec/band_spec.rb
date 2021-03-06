require('spec_helper')

describe(Band) do
  it {should have_and_belong_to_many(:venues)}
end

describe(Band) do
  it("validates presence of name") do
    band = Band.create({:name => ""})
    expect(band.save()).to(eq(false))
  end
end
