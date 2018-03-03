require "pry"

Dir["./src/**/*.rb"].each {|file| require file }

module BlogPosts
  class Interactor
    MARKDOWN_DIR_PATH = "posts__markdown".freeze
    HTML_DIR_PATH     = "posts__html".freeze

    def call
      markdown_directory = Persistance::Directory.new(directory_path: markdown_dir_path)
      file_collection = []

      markdown_directory.read
      markdown_directory.file_collection.each do |file|
        post_data = Adapters::MarkdownFileToPostEntity.new(file: file).call

        post_entity = PostEntity.new(
          date: post_data[:date],
          title: post_data[:title],
          category: post_data[:category],
          html_content: post_data[:html_content],
        )

        file_data = Adapters::PostEntityToHTMLFile.new(entity: post_entity).call

        html_file = Persistance::File.new(
          filename: file_data[:filename],
          content: file_data[:content],
        )

        file_collection << html_file
      end

      html_directory = Persistance::Directory.new(directory_path: html_dir_path, file_collection: file_collection)
      html_directory.write
    end

    private

    def markdown_dir_path
      MARKDOWN_DIR_PATH
    end

    def html_dir_path
      HTML_DIR_PATH
    end
  end
end

BlogPosts::Interactor.new.call
