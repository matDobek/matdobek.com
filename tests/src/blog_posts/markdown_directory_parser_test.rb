require "test/unit"
require "mocha/test_unit"

require "./src/blog_posts/markdown_directory_parser"

class BlogPosts::MarkdownDirectoryParserTest < Test::Unit::TestCase
  def class_under_test
    ::BlogPosts::MarkdownDirectoryParser
  end

  def test_data___returns_array_with_results___when_file_exists
    files_data = [
      { filename: "1990-01-01__ruby__foo.md", content: "content of foo" },
      { filename: "1994-01-01__js__bar.txt", content: "content of bar" },
    ]
    object_under_test = class_under_test.new(files_data: files_data)

    result = object_under_test.data

    expected_result = [
      { date: "1990-01-01", category: "ruby", title: "foo", extension: "md", content: "content of foo"},
      { date: "1994-01-01", category: "js", title: "bar", extension: "txt", content: "content of bar"},
    ]
    assert_equal(expected_result, result)
  end

  def test_data___returns_array_with_results___when_file_doesnt_have_extenstion
    files_data = [
      { filename: "1990-01-01__ruby__foo", content: "content of foo" },
    ]
    object_under_test = class_under_test.new(files_data: files_data)

    result = object_under_test.data

    expected_result = [
      { date: "1990-01-01", category: "ruby", title: "foo", extension: "", content: "content of foo"},
    ]
    assert_equal(expected_result, result)
  end

  def test_data___returns_empty_array___when_file_doesnt_exist
    object_under_test = class_under_test.new(files_data: [])

    result = object_under_test.data

    assert_equal([], result)
  end
end
