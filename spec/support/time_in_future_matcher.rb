Spec::Matchers.define :be_in_the_past do
  match do |time|
    time < Time.now
  end
end