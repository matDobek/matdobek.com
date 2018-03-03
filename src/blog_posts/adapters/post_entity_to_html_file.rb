module BlogPosts
  module Adapters
    class PostEntityToHTMLFile
      METADATA_SEPARATOR = "__".freeze
      EXTENSTION         = "html".freeze

      def initialize(entity:)
        @entity = entity
      end

      def call
        filename                = [date, category, title].join(metadata_separator)
        filename_with_extension = "#{filename}.#{extenstion}"
        content                 = html_content

        {
          filename: filename_with_extension,
          content: content,
        }
      end

      private

      attr_reader :entity

      def extenstion
        EXTENSTION
      end

      def metadata_separator
        METADATA_SEPARATOR
      end

      def title
        entity.title.downcase.tr(" ", "_")
      end

      def category
        entity.category
      end

      def date
        entity.date
      end

      def html_content
        article = entity.html_content
        head_author = "Mateusz Dobek"
        head_keywords = "Mateusz,Dobek,matdobek," + title.tr("_", ",")
        body_title = entity.title
        head_description = entity.title
        head_title = entity.title

        <<~HEREDOC
          <head>
            <meta charset="UTF-8">
            <meta name="description" content="#{head_description}">
            <meta name="keywords" content="#{head_keywords}">
            <meta name="author" content="#{head_author}">
            <title>#{head_title}</title>
            <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
          </head>

          <body>
            <h1>#{body_title}</h1>
          #{article}
          </body>
        HEREDOC
      end
    end
  end
end
