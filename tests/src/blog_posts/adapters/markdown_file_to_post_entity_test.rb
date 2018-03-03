require "./tests/test_helper"

class BlogPosts::Adapters::MarkdownFileToPostEntityTest < Test::Unit::TestCase
  def class_under_test
    BlogPosts::Adapters::MarkdownFileToPostEntity
  end

  def object_under_test
    fake_file = Object.new
    def fake_file.filename; "1990-01-01__ruby_on_rails__foo_bar" ; end
    def fake_file.content; "## Foo bar content" ; end

    class_under_test.new(file: fake_file)
  end

  def test_call
    result = object_under_test.call
    expected_result = {
      date: "1990-01-01",
      title: "Foo bar",
      category: "ruby_on_rails",
      html_content: "<h2 id=\"foo-bar-content\">Foo bar content</h2>\n",
    }
    assert_equal(expected_result, result)
  end
end
