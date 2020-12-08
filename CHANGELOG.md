# Changelog

## [0.1.3] - 2020-12-08  Dean Wilson <dean.wilson@gmail.com>
### Changed
- added a test and fix for issue #48 - "Plugin does not always detect missing `.erb`" raised by @bastelfreak

## [0.1.1] - 2017-11-14  Dean Wilson <dean.wilson@gmail.com>

###  Changed
- Handle `epp` function calls with a parameter hash.
  In previous versions calling `epp` and passing in a parameter hash
  caused the function to fail and raise an error. Many thanks to
  @pmuller for finding the issue (#3) and providing the original
  spec contribution) and @seanmil for a full fix PR (#4) including
  spec tests!
