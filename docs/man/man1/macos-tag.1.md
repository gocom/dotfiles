% MACOS-TAG(1)
% Jukka Svahn
% October 2018

# NAME

macos-tag -- macOS file tags

# SYNOPSIS

**macos-tag** [*options*] [*command*] [[*tag* ...] [*filename*]]

# DESCRIPTION

List and edit macOS **Finder** file tags embedded in the
`com.apple.metadata:_kMDItemUserTags` extended file attribute.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

*tag*
: A case-sensitive tag name.

*filename*
: Path to a target file.

# COMMANDS

`add` `<`*tag* ...`>` `<`*filename*`>`
: Add tags to a file.

`list` `<`*filename* ...`>`
: List file's tags.

`remove` `<`*tag* ...`>` `<`*filename*`>`
: Remove tags from a file.

`reverse` `<`*filename*`>`
: Reverse the order of tags.

`sort` `<`*filename*`>`
: Sort file's tags to alphabetical order.

# FILES

Depends on external programs `bash`, `cat`, `jq`, `plutil`, `xattr` and `xxd`.

# EXAMPLES

Add tags `nature` `woods` and `forest` to a file `picture.jpg`:

    $ macos-tag add nature woods forest picture.jpg

List tags for a `picture.jpg`:

    $ macos-tag list picture.jpg

Remove `nature` tag from `picture.jpg`:

    $ macos-tag remove nature picture.jpg
