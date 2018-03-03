module BlogPosts
  module Adapters
    class MarkdownFileToPostEntity
      METADATA_SEPARATOR = "__".freeze

      def initialize(file:)
        @file = file
      end

      def call
        date, category, title = file.filename.split(metadata_separator)
        markdown_content      = file.content

        {
          date: date,
          title: formatted_title(title),
          category: category,
          html_content: convert_to_html(markdown_content),
        }
      end

      private

      attr_reader :file

      def metadata_separator
        METADATA_SEPARATOR
      end

      def formatted_title(title)
        title = title.tr("_", " ")

        title_chars = title.chars
        title_chars[0] = title_chars[0].upcase
        title = title_chars.join

        title
      end

      def convert_to_html(markdown_content)
        ::MarkdownConverter.new(markdown: markdown_content).call
      end
    end
  end
end
