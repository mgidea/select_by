require "select_by/version"
require "select_by/core_extensions/array/selecting_by"
module SelectBy
  Array.include SelectBy::CoreExtensions::Array::SelectingBy
end
