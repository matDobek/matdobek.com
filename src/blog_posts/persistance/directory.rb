module BlogPosts
  module Persistance
    class Directory
      def initialize(directory_path:, file_collection: [])
        @directory_path = directory_path
        @file_collection = file_collection
      end

      attr_reader :directory_path, :file_collection

      def read
        directory_content_without_default_dirs.each do |filename|
          content = nil

          ::File.open(path_of(filename)) do |file|
            content = file.read(file.size)
          end

          @file_collection << File.new(filename: filename, content: content)
        end

        self
      end

      def write
        directory_content_without_default_dirs.each do |filename|
          ::File.delete(path_of(filename))
        end

        file_collection.each do |file|
          filename  = file.filename
          extension = file.extension
          content   = file.content

          path = path_of("#{filename}.#{extension}")

          ::File.open(path, "w") { |f| f.write(content) }
        end

        self
      end

      private

      def directory_content
        ::Dir.new(directory_path).entries
      end

      def directory_content_without_default_dirs
        Array(directory_content[2..-1])
      end

      def path_of(filename)
        "#{directory_path}/#{filename}"
      end
    end
  end
end
