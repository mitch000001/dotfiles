require "rspec"
require "<%= file_name %>"

describe <%= klass %> do
  let(:<%= file_name %>) {<%= klass %>.new}
  subject {<%= file_name %>}
  it {should_not be_nil}
end
