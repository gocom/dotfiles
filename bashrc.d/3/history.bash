# Ignore commands starting with space or tab.
HISTCONTROL=ignoreboth:erasedups

# Append history buffer to the file on each command prompt.
df::prompt_command_append 'history -a'

# Previous command, command starting with a space or a tab.
bshtr::ignore "&" " *" "\\\\t*"

# Common commands
bshtr::remove "forget" "forget .*" \
  "\?" "\? .*" \
  "history" "history.*" \
  "l" "la" "ll" "ls" "ls -." \
  "man" "man .*" \
  "readlink .*" \
  "shopt .*" \
  "which" "which .*"

# Nukes.
bshtr::remove "dd" "dd .*" \
  "killall" "killall .*" \
  "mv" "mv .*" \
  "rm" "rm .*" \
  "rmdir" "rmdir .*"

# Help options.
bshtr::remove ".* -h" ".* -h .*" \
  ".* --help" ".* --help .*" ".* --help=.*" \
  ".* help" ".* help .*"

# Version options.
bshtr::remove ".* -v" ".* -v .*" \
  ".* --version" ".* --version .*" \
  ".* version"

# Password arguments.
bshtr::remove "mysql .* -p.+" "ssh .* -p.+" ".* --password=.*"

# Apm.
bshtr::remove "apm clean.*" "apm config.*" "apm dedupe.*" "apm deinstall.*" \
  "apm erase.*" "apm remove.*" "apm rm.*" "apm search.*" "apm uninstall.*" \
  "apm unlink.*" "apm unpublish.*"

# Apt-get.
bshtr::remove "apt-get remove.*"

# Bower.
bshtr::remove "bower lookup.*" "bower register.*" "bower search.*" \
  "bower uninstall.*"

# Homebrew.
bshtr::remove "brew config.*" "brew create.*" "brew home.*" "brew info.*" \
  "brew search.*" "brew uninstall.*"

# Bundler.
bshtr::remove "bundle config.*" "bundle clean.*"

# Composer.
bshtr::remove "composer clear-cache.*" "composer clearcache.*" \
  "composer config.*" "composer list.*" "composer remove.*" \
  "composer search.*"

# Gem.
bshtr::remove "gem cleanup.*" "gem help.*" "gem pristine.*" "gem push.*" \
  "gem yank.*"

# npm.
bshtr::remove "npm config.*" "npm ddp.*" "npm deprecate.*" "npm find.*" \
  "npm prune.*" "npm publish.*" "npm r .*" "npm rm .*" "npm s .*" \
  "npm se .*" "npm search.*" "npm un .*" "npm uninstall.*" \
  "npm unpublish.*" "npm unlink.*"

# Cron.
bshtr::remove "bg" "bg .*" "fg" "fg .*"

# Turn history control on.
bshtr::on
