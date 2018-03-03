module BlogPosts
  class PostEntity
    def initialize(date:, category:, title:, html_content:)
      @date = date
      @category = category
      @title = title
      @html_content = html_content
    end

    def date
      String(@date)
    end

    def category
      String(@category)
    end

    def title
      String(@title)
    end

    def html_content
      String(@html_content)
    end
  end
end
