% FUZ(1)
% Jukka Svahn
% July 2026

# NAME

fuz -- Skyrim SE LipGenerator wrapper

# SYNOPSIS

**fuz* [*options*] [*command*]

# DESCRIPTION

Allows generating fuz dialogue audio files for Skyrim SE from loose wav or
mp3 files, and extracting audio from fuz files.

# OPTIONS

`-h`, `--help`
: Print help.

`-v`, `--version`
: Print version number.

# COMMANDS

`extract`
: Extracts lip and wav files from the .fuz files found in the current working
directory.

`generate`
: Runs all individual generate command in succession, generating
the final .fuz files from the current working directory contents.
Resulting .fuz files are saved to ./dist directory.

`generate:dialogue`
: Generates dialogue text files next to wav files found in the current
working directory, if the dialogue text file is missing. The dialogue
file content defaults to the filename, with underscores (_) replaced
with spaces.

`generate:fuz`
: Generates fuz files from matching lip and xwm files found
in the current working directory. Results are saved to ./dist/ directory.

`generate:lip`
: Generates lip files from matching dialogue .txt files and .wav files found
in the current working directory. If a matching .lip file already exists,
generation is skipped.

`generate:wav`
: Generates wav files from mp3 files in the current working directory. If a
matching .wav file already exists, generation is skipped.

`generate:xwm`
: Generates xwm files from wav files in the current working directory. If a
matching .xwm file already exists, generation is skipped.

# ENVIRONMENT

`FUZ_FFMPEG`
: Specifies FFMpeg executable location. If not specified, defaults to
`/mnt/c/Program Files/ffmpeg/bin/ffmpeg.exe`.

`FUZ_LIPFUZER`
: Specifies LIPFuzer executable location. If not specified, defaults to
`/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Tools/LipGen/LipFuzer/LIPFuzer.exe`.

`FUZ_LIPGENERATOR`
: Specifies LipGenerator executable location. If not specified, defaults to
`/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Tools/LipGen/LipGenerator/LipGenerator.exe`.

`FUZ_XWMAENCODE`
: Specifies XWMAEncode executable location. If not specified, defaults to
`/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Tools/Audio/xwmaencode.exe`.

# FILES

Depends on external programs `basename`, `bash`, `ffmpeg.exe`, `grep`,
`LIPFuzer.exe`, `LipGenerator.exe`, `ls`, `mkdir`, `sed`, `wc`
and `xwmaencode.exe`.

`LIPFuzer.exe`, `LipGenerator.exe` and `xwmaencode.exe` are part of
Skyrim's Creation Kit.

# EXAMPLES

Generates fuz files from mp3 or wav files located in the current working
directory:

    $ fuz generate

Generate only dialogue text files for all wav files, which can then be filled
to match the spoken line. The default content is based on the .wav file's
filename:

    $ fuz generate:dialogue
