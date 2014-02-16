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
    category = ask("category?(plugin, config, box)", ['p','c', 'b'])
    if category == 'p'
      category = 'plugins'
      type = ask_plugin_type
      link = get_stdin("link? (eg. https://example.com/)")
    elsif category == 'c'
      category = 'configs'
      link = get_stdin("link? (eg. https://example.com/)")
      supported = get_stdin("supported providers(eg. virtualbox, vmware)?")
    elsif category == 'b'
      category = 'boxes'
      link = get_stdin("link? (eg. https://example.com/)")
      size = get_stdin("Size?(eg. 100MB)")
    else
      category = 'misc'
      link = get_stdin("link? (eg. https://example.com/)")
    end
  end

  desc = get_stdin("Description(eg. VirtualBox provider)?:")
  taglist = get_stdin("Tags?(eg. tag1,tag2)")
  tags = taglist.downcase.strip.split(',')

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

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "name: \"#{name}\""
    if category=="plugins"
      post.puts "doc:"
      post.puts "type: #{type}"
    elsif category=="configs"
      post.puts "box:"
      post.puts "providers: #{supported}"
    elsif category=="boxes"
      post.puts "size: #{size}"
    else
      # nothing to do
    end
    post.puts "link: #{link}"
    post.puts "description: #{desc}"
    post.puts "category: #{category}"
    post.puts "tags:"
    tags.each do |t|
      post.puts" - #{t}"
    end
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

def ask_plugin_type
  case ask("plugin type?(_Provider, p_Rovisioner, _Command, _Sync)", ['p','r','c','s'])
  when 'p'
    type = "provider"
  when 'r'
    type = "provisioner"
  when 'c'
    type = "command"
  when 's'
    type = "sync_folder"
  else
    type = "unknown"
  end
  type
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end
