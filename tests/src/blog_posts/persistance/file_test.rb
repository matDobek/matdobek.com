require "./tests/test_helper"

class BlogPosts::Persistance::FileTest < Test::Unit::TestCase
  def class_under_test
    ::BlogPosts::Persistance::File
  end

  def test_filename___returns_filename_without_extension___when_extension_present
    object_under_test = class_under_test.new(filename: "sample.md", content: "")
    assert_equal("sample", object_under_test.filename)
  end

  def test_filename___returns_filename_without_extension___when_extension_not_present
    object_under_test = class_under_test.new(filename: "sample", content: "")
    assert_equal("sample", object_under_test.filename)
  end

  def test_extension___returns_extension___when_extension_present
    object_under_test = class_under_test.new(filename: "sample.md", content: "")
    assert_equal("md", object_under_test.extension)
  end

  def test_extension___returns_empty_string___when_extension_not_present
    object_under_test = class_under_test.new(filename: "sample", content: "")
    assert_equal("", object_under_test.extension)
  end

  def test_content___returns_content
    object_under_test = class_under_test.new(filename: "sample.md", content: "content")
    assert_equal("content", object_under_test.content)
  end

  def test_comparasion___when_filename_extension_and_content_are_the_same
    object_1 = class_under_test.new(filename: "sample.md", content: "content")
    object_2 = class_under_test.new(filename: "sample.md", content: "content")

    assert_equal(object_1, object_2)
  end

  def test_comparasion___when_filename_differs
    object_1 = class_under_test.new(filename: "foo.md", content: "content")
    object_2 = class_under_test.new(filename: "bar.md", content: "content")

    assert_not_equal(object_1, object_2)
  end

  def test_comparasion___when_extension_differs
    object_1 = class_under_test.new(filename: "sample.md", content: "content")
    object_2 = class_under_test.new(filename: "sample.txt", content: "content")

    assert_not_equal(object_1, object_2)
  end

  def test_comparasion___when_content_differs
    object_1 = class_under_test.new(filename: "sample.md", content: "foo")
    object_2 = class_under_test.new(filename: "sample.md", content: "bar")

    assert_not_equal(object_1, object_2)
  end
end
