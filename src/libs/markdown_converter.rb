require "kramdown"

class MarkdownConverter
  def initialize(markdown:)
    @markdown = markdown
  end

  def call
    ::Kramdown::Document.new(markdown, {
      input: "GFM",
      coderay_line_numbers: :table, # :inline, :table, nil
      coderay_css: :style, # :class, :style
    }).to_html
  end

  private

  attr_reader :markdown
end

