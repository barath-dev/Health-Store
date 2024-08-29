const fs = require('fs');
const skipWords = fs.readFileSync('eslint.skipWords.txt', 'utf8')
                      .split('\n')
                      .map(line => line.trim())
                      .filter(line => !!line);

const OFF = 0;
const WARN = 1;
const ERROR = 2;

module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins:
  [
    '@typescript-eslint',
    'spellcheck',
  ],
  extends:
  [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:@typescript-eslint/recommended-requiring-type-checking',
  ],
  parserOptions: {
    project: ['tsconfig.json'],
    tsconfigRootDir:__dirname,
  },
  settings: {
    "import/parsers": {
      "@typescript-eslint/parser": [".ts", ".tsx"]
    },
    "import/resolver": {
      "typescript": {}
    },
  },
  rules: {
    '@typescript-eslint/no-confusing-void-expression': ERROR,
    '@typescript-eslint/prefer-readonly': ERROR,
    'spellcheck/spell-checker': [WARN, {
      'comments': true,
      'strings': true,
      'identifiers': true,
      'templates': false,
      'lang': 'en_US',
      'skipWords': skipWords,
      'skipIfMatch': [
        'dat\\.GUI',
        'TODO\\s*\\([^\\)]+\\):',
      ],
    }],
  },
};