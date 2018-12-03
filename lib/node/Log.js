const process = require('process');
const {Console} = require('console');
const NullConsole = require('./NullConsole');

/**
 * Log.
 */

class Log {
  /**
   * Constructor.
   */

  constructor () {
    this._output = process.stdout;
    this._errput = process.stderr;
    this._enabled = true;
    this._color = false;
    this._console = null;
    this.init();
  }

  /**
   * Initializes.
   */

  init () {
    if (this._enabled) {
      this._console = new Console(process.stdout, process.stderr, true);
    } else {
      this._console = new NullConsole();
    }

    return this;
  }

  /**
   * Sets output stream.
   *
   * @param {Stream} output
   * @return {Log}
   */

  output (output) {
    this._output = output;
    this.init();
    return this;
  }

  /**
   * Sets error output stream.
   *
   * @param {Stream} output
   * @return {Log}
   */

  errput (output) {
    this._errput = output;
    this.init();
    return this;
  }

  /**
   * Enables or disables the instance.
   *
   * @param {Boolean} enable
   * @return {Log}
   */

  enable (enable) {
    this._enabled = !(!enable);
    this.init();
    return this;
  }

  /**
   * Formats a message string.
   *
   * @param {mixed} message
   * @return {string}
   */

  format (message) {
    let r = message;

    if (r === undefined || r === null || r === '' || r === true) {
      return this;
    }

    if (typeof r !== 'string') {
      try {
        r = JSON.stringify(r);
      } catch (e) {
        return this;
      }
    }

    return ('' + r).trim();
  }

  /**
   * Writes a message.
   *
   * @param {string} message
   */

  write (message) {
    if (this._enabled === true) {
      this._output.write(message);
    }

    return this;
  }

  /**
   * Writes a line.
   *
   * @param {string} message
   */

  writeln (message) {
    this.write(`${message}\n`);
    return this;
  }

  /**
   */

  /*reflect () {
    let methods = [
      'assert',
      'clear',
      'count',
      'countReset',
      'debug',
      'error',
      'group',
      'info',
      'log',
      'table',
      'trace',
      'warn'
    ];

    methods.forEach((method) => {
      this[method] = function () {
        this.console[method].apply(this.console, arguments);
        return this;
      };
    });
  }*/

/*
  new Console(options)
console.assert(value[, ...message])
console.clear()
console.count([label])
console.countReset([label])
console.debug(data[, ...args])
console.dir(obj[, options])
console.dirxml(...data)
console.error([data][, ...args])
console.group([...label])
console.groupCollapsed()
console.groupEnd()
console.info([data][, ...args])
console.log([data][, ...args])
console.table(tabularData[, properties])
console.time([label])
console.timeEnd([label])
console.timeLog([label][, ...data])
console.trace([message][, ...args])
console.warn([data][, ...args])*/

  error () {
    this.console.error.apply(this, arguments);
    return this;
  }

  warn () {
    this.console.warn.apply(this, arguments);
    return this;
  }

  /**
   */

  log (message) {
    this.console.log.apply(this, arguments);
    return this;
  }

  /**
   */

  get console () {
    return this._console;
  }

  /**
   */

  static open () {
    return new Log();
  }
}

/**
 * Default instance.
 *
 * @var {Log}
 */

Log.ok = Log.open();

/**
 * Verbose logger.
 *
 * @var {Log}
 */

Log.verbose = Log.open().enable(false);

/**
 * Error logger.
 *
 * @var {Log}
 */

Log.error = Log.open().output(process.stderr).enable(false);

module.exports = Log;
