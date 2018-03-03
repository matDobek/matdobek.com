require "./tests/test_helper"

class BlogPosts::PostEntityTest < Test::Unit::TestCase
  def class_under_test
    ::BlogPosts::PostEntity
  end

  def object_under_test
    class_under_test.new(
      date: "1990-01-01",
      category: "foo",
      title: "Foo like a pro",
      html_content: "Foo content",
    )
  end

  def test_date
    assert_equal("1990-01-01", object_under_test.date)
  end

  def test_category
    assert_equal("foo", object_under_test.category)
  end

  def test_title
    assert_equal("Foo like a pro", object_under_test.title)
  end

  def test_html_content
    assert_equal("Foo content", object_under_test.html_content)
  end
end
