module BlogPosts
  module Persistance
    class File
      def initialize(filename:, content:)
        @filename, @extension = filename.split(".")
        @content = content
      end

      def filename
        String(@filename)
      end

      def extension
        String(@extension)
      end

      def content
        String(@content)
      end

      def ==(obj)
        self.filename == obj.filename &&
          self.extension == obj.extension &&
          self.content == obj.content
      end
    end
  end
end
