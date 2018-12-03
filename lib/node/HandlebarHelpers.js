const process = require('process');
const mime = require('mime-types');
const path = require('path');
const moment = require('moment');
const fs = require('fs');
const child_process = require('child_process');
const crypto = require('crypto');
const handlebars = require('handlebars');

/**
 * Collection of handlebar helpers.
 */

class HandlebarHelpers {
  /**
   * Constructor.
   *
   * @param {Handlebars} engine Instance of Handlebars
   */

  constructor (engine) {
    if (engine) {
      this.handlebars = engine;
    } else {
      this.handlebars = handlebars.create();
    }

    this.context = {};
    this.options = {};
    this.variableRegex = /{{{?[#/]?(.*?)}?}}/g;
    this.helpers = {};
    this.generators = [];
  }

  /**
   * Initializes default helpers.
   */

  init () {
    return this
      .helper('lower')
      .helper('upper')
      .helper('capitalize')
      .helper('ascii')
      .helper('pad')
      .helper('split')
      .helper('slice')
      .helper('word')
      .helper('char')
      .helper(['index', 'i'])
      .helper(['number', 'n'])
      .helper('image')
      .helper('video')
      .helper('date')
      .helper('head')
      .generator('id3')
      .generator(['width', 'w'])
      .generator(['height', 'h'])
      .generator('mime')
      .generator('type')
      .generator('content')
      .generator('json')
      .generator('md5')
      .generator('sha256')
      .generator('version');
  }

  /**
   */

  compile (template, options) {
    let matches, callees = [];

    const parse = this.handlebars.compile(template, options);

    while ((matches = this.variableRegex.exec(template)) !== null) {
      matches[1].split(/\s/).forEach((variable) => {
        if ((variable = /^(\w+)(?:\.[\w\d]+|)$/.exec(variable)) !== null) {
          if (callees.indexOf(variable[1]) === -1) {
            callees.push(variable[1]);
          }
        }
      });
    }

    return (data) => {
      let variables = Object.assign({}, data);

      callees.forEach((name) => {
        const generator = this.generators
          .filter(g => g.name === name || g.aliases.indexOf(name) !== -1)
          .pop();

        if (generator) {
          const result = generator.fn.call(this, variables);

          generator.aliases.forEach((variable) => {
            variables[variable] = result;
          });

          variables[name] = result;
        }
      });

      return parse(variables);
    };
  }

  /**
   * Lowercase.
   */

  lower (r) {
    if (typeof r === 'string') {
      return r.toLowerCase();
    }
  }

  /**
   * Uppercase.
   */

  upper (r) {
    if (typeof r === 'string') {
      return r.toUpperCase();
    }
  }

  /**
   * Captilize the first letter.
   */

  capitalize (r) {
    if (typeof r === 'string') {
      return r.toUpperCase() + r.slice(1);
    }
  }

  /**
   * ASCII.
   */

  ascii (r) {
    if (typeof r === 'string') {
      return r.replace(/[^a-z0-9\s-_.,]/gmi, '');
    }
  }

  /**
   */

  episode (r) {
    if (typeof r === 'string') {
      let matches = r.match(/(?:e|episode.*?)([0-9]+(?:[.-][0-9]+)*)/i);

      if (matches) {
        return Number(matches[1]);
      }
    }
  }

  /**
   */

  season (r) {
    if (typeof r === 'string') {
      let matches = r.match(/(?:s|season.*?)([0-9]+(?:[.-][0-9]+)*)/i);

      if (matches) {
        return Number(matches[1]);
      }
    }
  }

  /**
   */

  suffix (r) {
    return this.split(r, /[._-\[]/, -1, 1).replace(/[\]]/gim, '');
  }

  /**
   */

  prefix () {
    return this.split(r, /[._-\]]/, 0, 1).replace(/[\[]/gim, '');
  }

  /**
   * Pad a string to a certain length.
   *
   * @param {String|Number} input The input to pad
   * @param {Number} length The target length
   * @param {String} pad A charact to use as the padding
   * @return {String}
   */

  pad (input, length, pad) {
    if (typeof input === 'string' || typeof input === 'number') {
      input = String(input);
    } else {
      input = '';
    }

    if (!length || !Number.isInteger(length)) {
      return input;
    }

    if (typeof pad === 'string' || typeof pad === 'number') {
      pad = String(pad)[0];
    } else {
      pad = '0';
    }

    if (length < 0) {
      return input.padEnd(length * -1, pad);
    }

    return input.padStart(length, pad);
  }

  /**
   * Extract a slice.
   *
   * @param {Number} begin
   * @param {Number} end
   * @return {Mixed}
   */

  slice (input, begin, end) {
    if (typeof input.slice === 'function') {
      return input.slice(begin, end);
    }

    if (typeof input === 'object') {
      return Object.entries(input).slice(begin, end);
    }

    return input;
  }

  /**
   * Zero-padded item index.
   */

  index (length, pad) {
    if (!length) {
      length = String(this.context.total - 1).length;
    }

    return this.pad(this.context.index, length, pad);
  }

  /**
   * Zero-padded item number.
   */

  number (length, pad) {
    if (!length) {
      length = String(this.context.total).length;
    }

    return this.pad(this.context.index + 1, length, pad);
  }

  /**
   * Executes a command and returns standard output.
   *
   * @param {String} command Command
   * @param {Array} args Arguments
   * @param {Object} options Options
   */

  exec (command, args, options) {
    let data;

    try {
      data = child_process.execFileSync(command, args, Object.assign({}, {
        stdio: ['pipe', 'pipe', 'ignore'],
        timeout: 5000,
        maxBuffer: 20480,
        encoding: 'utf8'
      }, options || {}));
    } catch (e) {
    }

    if (!data) {
      return;
    }

    if (this.isNumeric(data)) {
      return Number(data);
    }

    return data;
  }

  /**
   */

  isNumeric (input) {
    let number = Number(input);

    if (!Number.isNaN(number) && String(number) === input) {
      return true;
    }

    return false;
  }

  /**
   * Extract image data using ImageMagick.
   *
   * @param {String} format Format string
   * @return {Mixed}
   */

  image (format) {
    if (!this.context.path || !format) {
      return;
    }

    if (String(format).indexOf('%') === -1) {
      format = `%${format}`;
    }

    return this.exec('magick', [
      this.context.path, '-ping', '-format', format, 'info:'
    ]);
  }

  /**
   * Query a specific field from a JSON object.
   *
   * ```
   * const helper = new HandlebarHelpers();
   * const data = {items: [{name: {first: "John", last: "Doe"}}]};
   * helper.query(data, ['items', 0, 'name', 'first']);
   * ```
   *
   * @param {Object|Array} data Object-map or array to query
   * @param {String[]|Integer[]} field Field to extract
   * @return {mixed} The field
   */

  query (data) {
    let tree = Array.from(arguments).slice(1),
      node = data;

    if (tree.length === 1) {
      if (typeof tree[0] === 'string') {
        tree = tree[0].split(/[\[\].]/);
      } else if (Array.isArray(tree[0])) {
        tree = tree[0];
      }
    }

    tree.forEach((key) => {
      if (key === null || typeof key === 'undefined') {
        return;
      }

      node = Object.entries(node)
        .filter((r, i) => r[0] === key || i === key)
        .shift();

      if (!node) {
        return false;
      }

      node = node[1];
    });

    return node;
  }

  /**
   * Extract media data using ffmpeg.
   *
   * Same as running:
   *
   * ```
   * ffprobe -v quiet -print_format json -show_format -show_streams --
   * ```
   *
   * @param {Number|String} [field] A field to extract
   * @return {Mixed}
   * @private
   */

  media (field) {
    let data, args;

    data = this.exec('ffprobe', [
      '-v', 'quiet',
      '-print_format', 'json',
      '-show_format',
      '-show_streams',
      '--', this.context.path
    ]);

    if (data) {
      try {
        data = JSON.parse(data);
      } catch (e) {
        return;
      }
    }

    if (!data || !Object.values(data).length) {
      return;
    }

    if (!field) {
      return data;
    }

    args = Array.from(arguments);
    args.unshift(data);

    return this.query.apply(this, args);
  }

  /**
   * Gets info about a video.
   *
   * Extracts the specified field from a stream at index 0.
   *
   * @param {String} field The field
   * @return {mixed}
   */

  video (field) {
    return this.media('streams', 0, field);
  }

  /**
   * Gets a ID3 tag.
   *
   * @param {String} tag The tag
   * @return {mixed}
   */

  id3 (tag) {
    return this.media('format', 'tags', tag);
  }

  /**
   * Gets mime type.
   *
   * @return {String|Boolean}
   */

  mime () {
    return mime.lookup(this.context.ext);
  }

  /**
   * Gets media-type from the mime.
   *
   * @return {String|Boolean}
   */

  type () {
    let mime = this.mime();

    if (!mime) {
      return false;
    }

    return mime.split('/')[0];
  }

  /**
   * Image height.
   *
   * @return {Number}
   */

  height () {
    let result = this.image('%h');

    if (!result) {
      result = this.video('height');
    }

    return result;
  }

  /**
   * Image width.
   *
   * @return {Number}
   */

  width () {
    let result = this.image('%w');

    if (!result) {
      result = this.video('width');
    }

    return result;
  }

  /**
   */

  split (input, needle, offset, limit) {
    return String(input).split(needle)
      .slice(Number(offset || 0))
      .slice(0, Number(limit || 1))
      .join('');
  }

  /**
   */

  char (input, offset, limit) {
    return this.split(input, '', offset, limit);
  }

  /**
   */

  word (input, index) {
    return this.split(input, /[\s._-]+/, index);
  }

  /**
   */

  path () {
    if (arguments) {
      return path.join.apply(this, arguments);
    }

    return this.context.path;
  }

  /**
   */

  date (format, date) {
    return moment(date).format(format);
  }

  /**
   */

  content () {
    try {
      return fs.readFileSync(this.context.path, 'utf8');
    } catch (e) {
      return null;
    }
  }

  /**
   * Extrasts a value from a JSON file.
   *
   * ```
   * {{json version}}
   * ```
   *
   * @param {String} needle Property-value to extract
   * @return {Mixed} Value
   */

  json (needle) {
    try {
      let args = Array.from(arguments);
      args.unshift(JSON.parse(this.content()));
      return this.query.apply(this, args);
    } catch (e) {
    }
  }

  /**
   * Asks 'version' command for a version number.
   *
   */

  version () {
    return this.exec('version', [], {
      cwd: this.context.dir
    });
  }

  /**
   */

  head (offset, limit) {
    return this.split(this.content(), /[\n]/, offset, limit);
  }

  /**
   * @private
   */

  checksum (algorithm) {
    let content = this.content();

    if (content === null) {
      return;
    }

    return crypto.createHash(algorithm || 'sha256')
      .update(content)
      .digest('hex');
  }

  /**
   */

  sha256 () {
    return this.checksum('sha256');
  }

  /**
   */

  md5 () {
    return this.checksum('md5');
  }

  /**
   * Registers a new generator.
   *
   * A generator populates the template context object base on the variables
   * used in the template string.
   *
   * @param {String} name
   * @param {Function} fn Callback function
   * @return
   */

  generator (name, fn) {
    const helper = new HandlebarHelpers();

    if (!Array.isArray(name)) {
      name = [name];
    }

    if (!fn) {
      fn = name[0];
    }

    if (typeof fn === 'string') {
      fn = helper[fn];
    }

    this.generators.push({
      name: name[0],
      aliases: name.slice(1),
      fn (context, options) {
        helper.context = context || {};
        helper.options = options || {};
        return fn.apply(helper, options);
      }
    });

    return this;
  }

  /**
   * Registers a new helper.
   *
   * @param {String|Array} name Name of the helper
   * @param {Function} fn Callback function
   * @return {HandlebarHelpers}
   */

  helper (name, fn) {
    let helper = new HandlebarHelpers();

    if (!Array.isArray(name)) {
      name = [name];
    }

    if (!fn) {
      fn = name[0];
    }

    if (typeof fn === 'string') {
      fn = helper[fn];
    }

    name.forEach((n) => {
      this.handlebars.registerHelper(n, function () {
        let options = Array.from(arguments);
        helper.context = this;
        helper.options = options.pop();
        helper.name = n;
        return fn.apply(helper, options);
      });
    });

    return this;
  }

  /**
   */

  static register (hanblebars) {
    return new HandlebarHelpers(hanblebars).init();
  }
}

HandlebarHelpers.handlebars = HandlebarHelpers.register();
module.exports = HandlebarHelpers;
