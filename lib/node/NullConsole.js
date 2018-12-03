/**
 * Write Console output to nowhere.
 *
 * Used for verbose mode.
 *
 * @private
 */

class NullConsole {
  constructor () {
    return {
      assert () {},
      clear () {},
      count () {},
      debug () {},
      dir () {},
      log () {},
      error () {},
      table () {},
      warn () {}
    };
  }
}

module.exports = NullConsole;
