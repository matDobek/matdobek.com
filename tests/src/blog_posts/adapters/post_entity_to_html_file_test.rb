require "./tests/test_helper"

class BlogPosts::Adapters::PostEntityToHTMLFileTest < Test::Unit::TestCase
  def class_under_test
    ::BlogPosts::Adapters::PostEntityToHTMLFile
  end

  def object_under_test
    fake_entity = Object.new
    def fake_entity.html_content
      "<h2>Header hello</h2>\n<p>Paragraph hello</p>"
    end
    def fake_entity.title; "Foo bar"; end
    def fake_entity.category; "ruby"; end
    def fake_entity.date; "1990-01-01"; end

    class_under_test.new(entity: fake_entity)
  end

  def test_call
    expected_content = <<~HEREDOC
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta name="description" content="Foo bar">
          <meta name="keywords" content="Mateusz,Dobek,matdobek,foo,bar">
          <meta name="author" content="Mateusz Dobek">
          <title>Foo bar</title>
          <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
        </head>

        <body>
          <a href="../index.html">&#10094;&#10094;&#10094;</a>
          <h1>Foo bar</h1>
        <h2>Header hello</h2>
      <p>Paragraph hello</p>
        </body>
      </html>
    HEREDOC

    result = object_under_test.call
    expected_result = {
      filename: "1990-01-01__ruby__foo_bar.html",
      content: expected_content,
    }

    assert_equal(expected_result, result)
  end
end
