require "rubygems"
require 'rake'
require 'erb'

require "#{File.dirname(__FILE__)}/_lib/common_helper"
require "#{File.dirname(__FILE__)}/_lib/input_helper"
require "#{File.dirname(__FILE__)}/_lib/plugin_helper"

SOURCE = "."
CONFIG = {
  'layouts' => File.join(SOURCE, "_layouts"),
  'posts' => File.join(SOURCE, "_posts"),
  'post_ext' => "md",
}
if File.exist?('_vagrantlist_config.yml')
  CONFIG.merge!(CommonHelper.load_yaml('_vagrantlist_config.yml'))
end

# Usage: rake box name="A name" [date="2014-02-15"] [tags="tag1,tag2"]
desc "Add a new box to List"
task :box do
  atts = {}
  atts[:category] = 'boxes'
  atts.merge!(CommonHelper.common_part('boxes'))
  atts[:link] = InputHelper.get_stdin("link? (eg. https://example.com/)")
  atts[:size] = InputHelper.get_stdin("Size?(eg. 100MB)")
  atts[:arch] = InputHelper.ask_arch
  atts[:provider] = InputHelper.ask_single_provider
  atts[:committer] = InputHelper.get_stdin("committer?")
  CommonHelper.put_post(atts[:filename], atts)
end # task :box

# Usage: rake plugin name="A name" [date="2014-02-15"] [tags="tag1,tag2"]
desc "Add a new plugin to List"
task :plugin do
  atts = {}
  atts[:category] = 'plugins'
  atts.merge!(CommonHelper.common_part('plugins'))
  atts[:type] = InputHelper.ask_plugin_type
  atts[:link] = InputHelper.get_stdin("link? (eg. https://example.com/)")
  CommonHelper.put_post(atts[:filename], atts)
end # task :plugin

# Usage: rake recipe name="A name" [date="2014-02-15"] [tags="tag1,tag2"]
desc "Add a new recipe to List"
task :recipe do
  atts = {}
  atts[:category] = 'configs'
  atts.merge!(CommonHelper.common_part('configs'))
  atts[:link] = InputHelper.get_stdin("link? (eg. https://example.com/)")
  atts[:supported] = InputHelper.get_stdin("supported providers(eg. virtualbox, vmware)?")
  CommonHelper.put_post(atts[:filename], atts)
end # task :recipe

# Usage: rake usecase
desc "Add a new usecase to List"
task :usecase do
  atts = {}
  atts[:category] = 'usecases'
  atts.merge!(CommonHelper.common_part('usecases'))
  atts[:link] = InputHelper.get_stdin("link?(eg. https://example.com/)")
  atts[:supported] = InputHelper.get_stdin("supported providers?(eg. virtualbox, vmware)")
  CommonHelper.put_post(atts[:filename], atts)
end #task :usecase

desc "Launch preview environment"
task :preview do
  system "jekyll serve -w"
end # task :preview

# Usage: rake plugin_version
desc "Check gems versions and store to _data"
task :plugin_version do
  # load previous versions file if exist.
  version_data = CommonHelper.load_yaml('_data/plugin_versions.yml')
  PluginHelper.plugin_filelist.each do |file|
    open(file,'r').each do |line|
        plugin_name = PluginHelper.get_plugin_name(line)
        if plugin_name then
          puts "processing #{plugin_name}"
          ver = PluginHelper.gems_version(plugin_name)
          if ver
            version_data[plugin_name] = ver
          end
        end
    end
  end
  CommonHelper.write_yaml('_data/plugin_versions.yml', version_data)
end

# Usage: rake plugin_date
desc "Check github repository when it committed lately"
task :plugin_activity do
  # load previous versions file if exist.
  latest_data = CommonHelper.load_yaml('_data/plugin_activities.yml')
  # update dates.
  PluginHelper.plugin_filelist.each do |file|
    plugin_name = ""
    link_uri = ""
    open(file,'r').each do |line|
      if tmp = PluginHelper.get_plugin_name(line)
        plugin_name = tmp
        puts "processing #{plugin_name}"
      end
      if tmp = PluginHelper.get_plugin_link(line)
        link_uri = tmp
      end
    end
    if plugin_name && link_uri && /github.com/ =~ link_uri
      puts "check #{link_uri}"
      latest_data[plugin_name] = PluginHelper.github_activities(link_uri)
    end
  end
  CommonHelper.write_yaml('_data/plugin_activities.yml',latest_data)
end

