# Ruby Pocket

[![Code Climate](https://codeclimate.com/github/thiagoa/ruby_pocket/badges/gpa.svg)](https://codeclimate.com/github/thiagoa/ruby_pocket)
[![Test Coverage](https://codeclimate.com/github/thiagoa/ruby_pocket/badges/coverage.svg)](https://codeclimate.com/github/thiagoa/ruby_pocket/coverage)
[![Travis CI](https://travis-ci.org/thiagoa/ruby_pocket.svg)](https://travis-ci.org/thiagoa/ruby_pocket)

*A warm place to store your precious development references.*

Although it has *pocket* in its name, **Ruby Pocket** is not a **Pocket** nor a
**Readability** clone. It is a tool designed to store useful all-around
development articles and reference URLs. You can store any kind of URL, but its
main appeal is for developers, or for those who need to store technical
articles or references of any kind.

Why would you want to use something like that? Having made this tool for
myself, here are some reasons why you might want to use it too:

- You feel like work and technical references should not be mixed with other
  content types.
- You don't want to clutter your bookmarks with technical references.
- You don't want to clutter your **Pocket** or **Readability** account; they're
  meant to be read later lists, not permanent article stores.
- **You want to be the real owner, and have full control over your own data**.
  **Ruby Pocket** uses **SQLite3**; that means you're not limited to weird
  export formats, or to no export formats at all; you can do whatever you want
  with your data.
- You are a heavy command line user and lover, and don't want to break the flow
  when looking for a reference.
- You enjoy a clean, text-based, clutter-free list of favorites.
- You want to have your URLs at your disposal, in all your computers, or even
  have a private URL server. With a private URL server hosted in some place
  like **Heroku**, you can also consume your content on mobile devices (*not
  ready yet*).
- You want power searching (*not ready yet*).

If you're fine with your current method, whatever it is, just go with it :-)

## Current Features

Currently the app has a very simple feature set:

- Simple and delightful command line interface.
- Tagging support. Each favorite can have one or more tags.
- Add favorites.
- List favorites.
- Search favorites by tags.
- Delete favorites
- Open favorites in the default browser (currently for **OS X**)

## How to install

There is no RubyGem yet. Just clone the repo and install the dependencies:

```sh
bundle install
```

The binary is located in `bin/pocket`.

## Usage

Note: there are verbose versions for all commands presented here. See all
available options with the following command:

```sh
$ pocket -h
```

Add a favorite, fetching its name over the internet:

```sh
$ pocket -a https://github.com/jlevy/the-art-of-command-line

Favorite 'jlevy/the-art-of-command-line · GitHub' created!
```

Add a favorite, but specify its name:

```sh
$ pocket -a https://github.com/jlevy/the-art-of-command-line -t 'The Art of Command Line'

Favorite 'The Art of Command Line' created!
```

Add a favorite with tags. If more than one tag, separate with commas:

```sh
$ pocket -a https://github.com/jlevy/the-art-of-command-line -t command-line

Favorite 'jlevy/the-art-of-command-line · GitHub' created!
```

List all favorites:

```sh
$ pocket -l

+----+------------------------------------------------------------------+--------------------+
| ID | Name                                                             | Tags               |
+----+------------------------------------------------------------------+--------------------+
| 1  | Stronger Shell                                                   | shell-script       |
| 2  | The Art of Command Line                                          | command-line       |
+----+------------------------------------------------------------------+--------------------+
```

Filter favorites by tag. Can filter by more than one tag:

```sh
$ pocket -l -t command-line

+----+------------------------------------------------------------------+--------------------+
| ID | Name                                                             | Tags               |
+----+------------------------------------------------------------------+--------------------+
| 2  | The Art of Command Line                                          | command-line       |
+----+------------------------------------------------------------------+--------------------+
```

Open a favorite in your default browser. Use the ID of the favorite:

```sh
$ pocket -o 2
```

Delete favorites. Use the IDs of the favorites you want to delete, separated by
commas:

```sh
$ pocket -d 2

Favorite 'The Art of Command Line' deleted
```

## Planned Features

- Scrape more web page information: probably the main content of the page.
- Edit favorites.
- List available tags.
- Interactive command mode.
- Search favorites with partial tag matching.
- Search favorites by name or by content, with regex support.
- Group favorites by tag, and other useful view modes.
- Link database to another folder, such as **Dropbox**. That action shall be
  automated with a command line flag.
- Remote backup support.
- **Linux** support for opening favorites.
- **Sinatra** web app to consume the content on mobile devices (as another project, which uses the gem).
- **Sinatra** API to consume the content (as another project, which uses the gem).
- **Alfred** workflow (as another project).

## Developer information

This project is built with **Ruby**. The name **Ruby**, from **Ruby
Pocket**, doesn't necessarily refer to the language itself :-)

### Running the tests

Unit tests:

```sh
rake test
```

Feature tests:

```sh
rake test:feature
```

All tests:

```sh
rake test:all

# Works too
rake
```

Run an IRB console:

```sh
rake console
```

## Contributing

- Fork the project
- Create a feature branch
- Make your code changes with tests
- Make a Pull-Request

This project uses MIT\_LICENSE
