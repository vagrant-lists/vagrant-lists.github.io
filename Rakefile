require "rubygems"
require 'rake'
require 'yaml'
require 'time'

SOURCE = "."
CONFIG = {
  'layouts' => File.join(SOURCE, "_layouts"),
  'posts' => File.join(SOURCE, "_posts"),
  'post_ext' => "md",
}

# Usage: rake post name="A name" [category="plugins | configs"] [date="2014-02-15"]
desc "Begin a new post in #{CONFIG['posts']}"
task :post do
  abort("rake aborted: '#{CONFIG['posts']}' directory not found.") unless FileTest.directory?(CONFIG['posts'])
  name = ENV["name"] || "new post"
  tags = ENV["tags"] || "[]"
  category = ENV["category"] || ""
  if category.empty?
    category = ask("category?", ['p','c'])
    if category == 'p'
      category = 'plugins'
    else
      category = 'configs'
    end
  end
  category = "#{category.gsub(/-/,' ')}" if !category.empty?
  slug = name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  begin
    date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
  rescue => e
    puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
    exit -1
  end
  filename = File.join(CONFIG['posts'], "#{category}", "#{date}-#{slug}.#{CONFIG['post_ext']}")
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end

  desc = get_stdin("Description(eg. VirtualBox provider)?:")
  link = get_stdin("link? (eg. https://example.com/)")
  tags = get_stdin("tags? [tag1,tag2]")
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "name: \"#{name.gsub(/-/,' ')}\""
    if category=="plugin"
      post.puts "doc:"
    elsif
      post.puts "box:"
      post.puts "providers:"
    end
    post.puts 'description: #{desc}'
    post.puts 'link: #{link}'
    post.puts "category: #{category}"
    post.puts "tags: #{tags}"
    post.puts "---"
  end
end # task :post

desc "Launch preview environment"
task :preview do
  system "jekyll serve -w"
end # task :preview

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end
