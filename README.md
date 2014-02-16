# Vagrant listing site

This repository contains a directory of vagrant plugins and other resources.

Ideas heavily come from [vagrantboxes](http://vagrantbox.ex/) and
[its port to jekyll](https://github.com/fgrehm/vagrantboxes-gh-pages).

I respect these great work and borrow some assets to keep
design consistency for users.

## Listing categories

There are several listings with categories. We have

1. Plugins

1. Base box configs

1. Boxes

1. Vagrant aware applications/projects


## preparation

You need `jekyll` to update and preview the site.


## How to add new item

We can add item with `rake` command.
It ask you interactively about attribute of a project.


```
# Usage: rake post name="A name" [category="plugins | configs"] [date="2014-02-15"]
```

Here is an example.
```
$ rake post name="item name"
category?(plugin, config) _p_
plugin type?(_Provider, p_Rovisioner, _Command, _Sync) _p_
Description(eg. VirtualBox provider)?: _It is plugin_
link? (eg. https://example.com/): _https://github.com/author/project_
"tags? [tag1,tag2]: _linux, plugin_
```

## Preview a result

```
$ rake preview
```

You can see the result with browser pointing `localhost:4000`

