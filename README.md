findbyname
=======

A vim plugin for finding files with a split window

# FindByName

version 1.1

Adds a command to search a directory for files and outputs the results into a
split window. I was frustrated by the inability to output the results of vim's
built-in `find` into a searchable list and to easily search in a specific
directory.

Note that this will only work on a Unix-like system such as Linux or the MacOS
where the system command `find` is available.

## USAGE

This plugin adds the command FindByName which takes one or two arguments. The
first argument is a filename or part of a filename and the second is a path. In
both cases, the path is optional and will default to `.`.

To search for filenames containing the word 'foo' in the path `~/stuff/`, use
`FindByName` like so:

```
  :FindByName foo ~/stuff/
```

## Installation

If you're using [Pathogen](https://github.com/tpope/vim-pathogen) and have git
installed, it's very simple; just clone the project into your ~/.vim/bundle/ directory:

```
cd ~/.vim/bundle/
git clone https://github.com/sirbrillig/findbyname.vim
```

## Configuration

The plugin will default to opening the files it finds in a new buffer, but you
can set the option FindByName_Use_Tabs to 'true' to use a new tab instead.

```
let FindByName_Use_Tabs = 'true'
```
