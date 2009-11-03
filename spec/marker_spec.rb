require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

Spec::Matchers.define :mark do |guess|
  match do |marker|
    marker.guess (@guess = guess)
    @actual_mark = marker.mark
    @actual_mark == @mark
  end
  def with(mark)
    @mark = mark
    self
  end
  failure_message_for_should do |marker|
    "#{@guess.inspect} expected to mark as:\n#{@mark.inspect}, but got\n#{@actual_mark.inspect}"
  end
end
describe Marker do
  let(:marker) { Marker.new %w{r g y b} }
  def check_mark(guess, mark)
    marker.should mark(guess).with(mark)
  end
  context "Only positional matches" do
    context "1 match" do
      it "marks as ['p']" do
        check_mark(%w{r c c c}, ['p'])
      end
    end
    context "2 matches" do
      it "marks as ['p']" do
        check_mark(%w{r c c b}, ['p'] * 2)
      end
    end
    context "3 matches" do
      it "marks as ['p', 'p', 'p']" do
        check_mark(%w{r g c b}, ['p'] * 3)
      end
    end
    context "4 matches" do
      it "marks as ['p', 'p', 'p', 'p']" do
        check_mark(%w{r g y b}, ['p'] * 4)
      end
    end
  end
  context "Only non-positional matches" do
    context "0 matches" do
      it "marks as []" do
        check_mark(%w{c c c c}, [])
      end
    end
    context "1 matches" do
      it "marks as ['m']" do
        check_mark(%w{b c c c}, ['m'])
      end
    end
    context "2 matches" do
      it "return ['m', 'm']" do
        check_mark(%w{b y c c}, ['m'] * 2)
      end
    end
    context "3 matches" do
      it "marks as ['m', 'm', 'm']" do
        check_mark(%w{b y g c}, ['m'] * 3)
      end
    end
    context "4 matches" do
      it "marks as ['m', 'm', 'm', 'm']" do
        check_mark(%w{b y g r}, ['m'] * 4)
      end
    end
  end
end
