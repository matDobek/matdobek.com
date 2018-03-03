require "./tests/test_helper"

class BlogPosts::Persistance::DirectoryTest < Test::Unit::TestCase
  def class_under_test
    ::BlogPosts::Persistance::Directory
  end

  def test_read___fill_file_collection___when_files_exist
    object_under_test = class_under_test
      .new(directory_path: "tests/fixtures/directory_with_files")

    object_under_test.read

    expected_results = [
      BlogPosts::Persistance::File.new(filename: "sample_file.md", content: "Sample content.\n")
    ]
    assert_equal(expected_results, object_under_test.file_collection)
  end

  def test_read___doest_not_fill_file_collection___when_no_file_exists
    object_under_test = class_under_test
      .new(directory_path: "tests/fixtures/directory_without_files")

    object_under_test.read

    assert_equal([], object_under_test.file_collection)
  end

  def test_write___cleans_the_dir_before_writing_files
    path = "tests/fixtures/directory_for_writing_tests"
    ::File.open("#{path}/sample", "w") { |f| f.write("sample stuff") }

    object_under_test = class_under_test.new(directory_path: path)
    object_under_test.write

    no_of_files = ::Dir.new(path).entries.count

    assert_equal(2, no_of_files)
  end

  def test_write___creates_proper_files
    path = "tests/fixtures/directory_for_writing_tests"
    file_collection = [
      BlogPosts::Persistance::File.new(filename: "foo.md", content: "foo content"),
      BlogPosts::Persistance::File.new(filename: "bar.md", content: "bar content"),
    ]
    object_under_test = class_under_test.new(
      directory_path: path,
      file_collection: file_collection
    )

    object_under_test.write

    foo_content = ::File.open("#{path}/foo.md") { |file| file.read(file.size) }
    bar_content = ::File.open("#{path}/bar.md") { |file| file.read(file.size) }
    no_of_entries = ::Dir.new(path).entries.count

    assert_equal("foo content", foo_content)
    assert_equal("bar content", bar_content)
    assert_equal(4, no_of_entries)
  end
end
