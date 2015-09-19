# Change log

## [0.1.3] - 2015-09-19
### Fixed
- Migrations directory on gem was wrong

## [0.1.2] - 2015-09-19
### Fixed
- Gemspec, to add pocket executable command
- README info: new gem info and fix a command example

## [0.1.1] - 2015-09-19
### Added
- CodeClimate and Travis-CI
- CHANGELOG file

### Changed
- Transparent database migrations system
- Refactored ListAction, extracting FavoriteQuery object
- Transform project into a gem

### Fixed
- Obtain user's home directory more reliably
- Fix dev and test database names to have a .db suffix
- Improve app performance on all actions, except "add"
- Better exception message for SocketError
- Fixed misleading exception name

## [0.1.0] - 2015-09-14
### Added
- Add favorites
- List favorites
- Search favorites by tags
- Favorite tagging support
- Delete favorites
- Open favorites in the OS X default browser
