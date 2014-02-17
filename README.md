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
# Usage: rake (box|recipe|plugin|usecase) [name="A name"] [date="2014-02-15"] [tag="tag1,tag2"]
```

Here is an example.
```
$ rake plugin
plugin type?(_Provider, p_Rovisioner, Command, _Sync) p
Description(eg. VirtualBox provider)?: It is plugin
link? (eg. https://example.com/): https://github.com/author/project
"tags? [tag1,tag2]:  linux, plugin
```

You can do `rake box`, `rake recipe`, `rake usecase` and `rake plugin`

## Preview a result

```
$ rake preview
```

You can see the result with browser pointing `localhost:4000`

