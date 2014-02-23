require 'time'
require 'yaml'

require "#{File.dirname(__FILE__)}/input_helper"

module CommonHelper

def self.common_part(category)
  abort("rake aborted: '#{CONFIG['posts']}' directory not found.") unless FileTest.directory?(CONFIG['posts'])
  if ENV["name"].to_s == ''
    name = InputHelper.get_stdin("Name? ")
  else
    name = ENV["name"]
  end
  desc = InputHelper.get_stdin("Description(eg. VirtualBox provider)?: ")
  if ENV["tags"]
    tags = ENV["tags"].downcase.strip.split(',')
  else
    taglist = InputHelper.get_stdin("Tags?(eg. tag1,tag2)")
    tags = taglist.downcase.strip.split(',')
  end

  resp = InputHelper.get_stdin("Any note?:")
  if resp.empty?
    note=nil
  else
    note=resp
  end

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

  {:name=>name,:note=>note,:desc=>desc,:tags=>tags,:filename=>filename,:date=>date}
end

def put_post(filename, attribute)
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    attribute.each do |key, val|
      case key
      when :name then
        post.puts "name: \"#{val}\""
      when :link then
        post.puts "link: #{val}"
      when :desc then
        post.puts "description: \"#{val}\""
      when :category then
        post.puts "category: #{val}"
      when :size then
        post.puts "size: #{val}"
      when :tags then
        post.puts "tags:"
        val.each { |t|
          post.puts" - #{t}"
        }
      when :doc then
        post.puts "doc: #{val}"
      when :type then
        post.puts "type: #{val}"
      when :box then
        post.puts "box: #{box}"
      when :provider then
        post.puts "provider: #{val}"
      when :supported then
        post.puts "providers: #{val}"
      when :filename then
        # skip
      else
        post.puts "#{key}: #{val}"
      end
    end
    post.puts "---"
  end
end

def self.load_yaml(filename)
  result = {}
  if File.exist?(filename)
    result = YAML.load_file(File.join(filename))
  end
  result
end

def self.write_yaml(filename, data)
  outfile = File.join(filename)
  open(outfile, 'w') do |outf|
    outf.puts YAML.dump(data)
  end
end
end
