/**
 * Prompt.
 *
 * ```
 * new Prompt().ask('Your favorite color', (answer) => {
 *   console.log(answer);
 * });
 * ```
 */

class Prompt {
  /**
   * Constructor.
   */

  constructor () {
    this._method = null;
    this._message = null;
    this._fn = null;
  }

  /**
   * Prompt for a value.
   *
   * @param {string} message
   * @param {callback} fn
   */

  ask (message, fn) {
    this._method = 'question';
    this._message = message;
    this._fn = fn;
    this.constructor.queue.push(this);
    return this;
  }

  /**
   */

  static prompt () {
    let queue = Prompt.queue;

    let fn = function () {
      let r, rl;

      if (!queue.length) {
        return;
      }

      rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
      });

      r = queue.shift();

      rl.question(`${r._message}: `, (answer) => {
        if (r._fn) {
          r._fn.call(r, answer);
        }

        rl.close();
        fn();
      });
    };

    fn();
    return this;
  }
}

Prompt.queue = [];

module.exports = Prompt;
