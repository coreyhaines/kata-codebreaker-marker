require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Marker do
  let(:marker) { Marker.new %w{r b y g} }

  context "Positional and Non-positional mixed" do
    before(:each) do
      marker.guess %w{r b g y}
    end
    it "does not include positional in non-positional count" do
      marker.count_of_nonpositional_matches.should == 2
    end
    it "puts the positional markers first" do
      marker.mark.should == [Marker::PositionalMarker]*2 + [Marker::NonPositionalMarker]*2
    end
  end

  context "Only positional" do
    before(:each) do
      marker.stub(:count_of_nonpositional_matches).and_return 0
    end
    {
      %w{r c c c} => 1,
      %w{r b c c} => 2,
      %w{r b y c} => 3,
      %w{r b y g} => 4
    }.each_pair do |guess, count|
      context "#{count} match" do
        before(:each) do
          marker.guess guess
        end
        describe "#mark" do
          before(:each) do
            marker.stub(:count_of_positional_matches).and_return count
          end

          it "returns #{([Marker::PositionalMarker]*count).inspect}" do
            marker.mark.should == [Marker::PositionalMarker]*count
          end
        end
        describe "#count_of_positional_matches" do
          it "returns #{count}" do
            marker.count_of_positional_matches.should == count
          end
        end
      end
    end
  end

  context "Only non-positional" do
    before(:each) do
      marker.stub(:count_of_positional_matches).and_return 0
    end
    {
      %w{c c c c} => 0,
      %w{g c c c} => 1,
      %w{g y c c} => 2,
      %w{g y b c} => 3,
      %w{g y b r} => 4
    }.each_pair do |guess, count|
      context "#{count} matches" do
        before(:each) do
          marker.guess guess
        end

        describe "#mark" do
          before(:each) do
            marker.stub(:count_of_nonpositional_matches).and_return count
          end

          it "returns #{([Marker::NonPositionalMarker]*count).inspect}" do
            marker.mark.should == [Marker::NonPositionalMarker]*count
          end
        end
        describe "#count_of_nonpositional_matches" do
          it "returns #{count}" do
            marker.count_of_nonpositional_matches.should == count
          end
        end
      end
    end
  end
end

