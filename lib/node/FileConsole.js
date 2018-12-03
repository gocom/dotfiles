const {Console} = require('console');
const fs = require('fs');

/**
 * Writes Console output to a file.
 */

class FileConsole {
  /**
   * @param {string|stream.Writable} outfile Path to output file, or a stream
   * @param {string|stream.Writable} errfile Path to error output file, or a stream
   * @return {Console}
   */

  constructor (outfile, errfile) {
    if (typeof outfile === 'string') {
      outfile = fs.createWriteStream(outfile);
    }

    if (typeof errfile === 'string') {
      errfile = fs.createWriteStream(errfile);
    } else if (!errfile) {
      errfile = outfile;
    }

    return new Console({
      stdout: outfile,
      stderr: errfile,
      colorMode: false
    });
  }
}

module.exports = FileConsole;
