const process = require('child_process');
const path = require('path');
const fs = require('fs');

const helper = {
  magick: {
    identify (file, format) {
      let data = '', filename = path.join(file.dir, file.base);

      try {
        data = process.execFileSync('magick', [
          filename, '-ping', '-format', format, 'info:'
        ], {
          stdio: ['pipe', 'pipe', 'ignore']
        });
      } catch (e) {
      }

      return data;
    }
  }
};

/**
 *
 * @see https://github.com/jhotmann/node-rename-cli/blob/master/lib/replacements.js
 */

const replacements = {
  width: {
    name: 'Image width',
    description: 'Actual width in pixels',
    unique: true,
    function: function (file, args) {
      return helper.magick.identify(file, '%w');
    }
  },

  height: {
    name: 'Image height',
    description: 'Actual height in pixels',
    unique: true,
    function: function (file, args) {
      return helper.magick.identify(file, '%h');
    }
  },

  index: {
    name: 'Index',
    description: 'Zero-padded index number.',
    unique: true,
    parameters: {
      description: 'start|length',
      default: '1|0'
    },
    function: function (file, args) {
      let arg = args.split(/[^0-9-.]/), start, pad;

      start = Number(arg.shift()) || 0;
      pad = Number(arg.shift()) || 0;

      if (pad === 0) {
        pad = String(file.totalFiles).length;
      }

      return String(start - 1 + Number(file.index)).padStart(pad, '0');
    }
  },

  component: {
    name: 'Component',
    description: 'Filename component as separated by the delimiter.',
    unique: true,
    parameters: {
      description: 'index|delimiters',
      default: '0|._-'
    },
    function: function (file, args) {
      let match, parts, index = 0, delim = '._-';

      match = /^(\d+)[^\d]?(.*)$/.exec(args);

      if (match) {
        index = Number(match[1]);
        delim = match[2] || delim;
      }

      parts = file.name.split(new RegExp(`[${delim}]`));

      if (typeof parts[index] === 'string') {
        return parts[index];
      }

      return '';
    }
  },

  episode: {
    name: 'Episodic',
    description: '',
    unique: true,
    parameters: {
      description: 'Default episode start number',
      default: '1'
    },
    function: function (file, args) {
      let episode = Number(file.index) - 1 + Number(args);

      [/(\d+)$/, /e(\d+)/].forEach((pattern) => {
        let match = pattern.exec(file.name);

        if (match) {
          episode = Number(match[1]);
          return false;
        }
      });

      return episode;
    }
  },

  season: {
    name: 'Seasonal',
    description: '',
    unique: true,
    parameters: {
      description: 'Default season number',
      default: '1'
    },
    function: function (file, args) {
      let match, season = Number(args);

      match = /(\d+)$/.exec(path.basename(file.dir));

      if (match) {
        season = Number(match[1]);
      }

      return season;
    }
  },

  json: {
    name: 'JSON property value',
    description: 'JSON property value',
    unique: true,
    parameters: {
      description: 'Key or index',
      default: '0'
    },
    function: function (file, key) {
      let index, data = '', filename = path.join(file.dir, file.base);

      try {
        data = JSON.parse(fs.readFileSync(filename, 'utf8'));
        index = Number(key);

        if (!Number.isNaN(index) && index.toString() === key) {
          data = Object.values(data);
          key = [Number(key)];
        }

        if (!Array.isArray(key)) {
          key = key.split(/[:.|]/);
        }

        key.forEach((lookup) => {
          let index = Number(lookup);

          if (!Number.isNaN(index) && index.toString() === lookup) {
            lookup = index;
          }

          if (lookup in data) {
            data = data[lookup];
            return;
          }

          data = '';
          return false;
        });
      } catch (e) {
      }

      return data;
    }
  },

  head: {
    name: 'Head',
    description: 'Line from the top',
    unique: true,
    parameters: {
      description: 'Line index',
      default: '0'
    },
    function: function (file, args) {
      let data, filename = path.join(file.dir, file.base), index = Number(args);

      try {
        data = fs.readFileSync(filename, 'utf8').split(/[\n]/);
        data = data.slice(index).shift();

        if (typeof data === 'string') {
          return data.replace(/[^\w\d]/gi, '').trim().substring(0, 64);
        }
      } catch (e) {
      }

      return '';
    }
  }
};

module.exports = replacements;
