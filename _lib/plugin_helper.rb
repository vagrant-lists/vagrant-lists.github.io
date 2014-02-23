require "rubygems"
require 'json'
require 'open-uri'
require 'time'
require 'erb'

module PluginHelper

def self.plugin_filelist
  FileList.new('_posts/plugins/*.md')
end

def self.get_plugin_name(line)
  if m = /name:\s\"?(?<plugin>(\w|-)+)/.match(line)
    return m[:plugin]
  end
  nil
end

def self.get_plugin_link(line)
  if m = /link:\s+(?<url>.+)/.match(line)
    return m[:url]
  end
  nil
end

def self.gems_version(plugin)
  ans = `gem query -n #{plugin} --remote`
  if m = /^#{plugin}\s+\((?<version>[0-9\.]+)\)/.match(ans)
    return m[:version]
  end
  nil
end

def self.github_activities(gh_url)
  uri_path = URI.parse(gh_url).path
  gh_path = uri_path.split('/')
  epoc = DateTime.now << 3 # last 3 month
  com = get_commits_github_api(gh_path[1], gh_path[2], epoc.iso8601)
  commits = com.length
  if commits == 0 # no activity last 3 month
    # get latest activity
    com = get_commits_github_api(gh_path[1],gh_path[2])
  elsif commits == 100
    commits = "99+"
  end
  last_act = com[0]['commit']['committer']['date']
  last_date = DateTime.parse(last_act).strftime('%F')

  return {"last" => last_date, "commits" => commits}
end

def self.get_commits_github_api(user, repo, since=nil)
  res = {}
  if since
    req_url = "https://api.github.com/repos/#{user}/#{repo}/commits?page=1&per_page=100&since=#{since}"
  else
    req_url = "https://api.github.com/repos/#{user}/#{repo}/commits"
  end
  begin
    open(req_url, http_basic_authentication: ["#{CONFIG['github_username']}", "#{CONFIG['github_password']}"]) { |f|
      data = f.read
      res = JSON.parse(data)
    }
  rescue OpenURI::HTTPError => ex
    puts "Missing github link!"
  end
  res
end

end
