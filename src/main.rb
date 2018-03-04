require "pry"
Dir["./src/**/*.rb"].each {|file| require file }

::BlogPosts::Creators::FromMarkdown.new.call
