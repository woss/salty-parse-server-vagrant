var express = require('express');
var ParseServer = require('parse-server').ParseServer;
var env = require('node-env-file');
var app = express();

env(__dirname + '/.env');

var envs = process.env;
var url = envs.PARSE_PROTOCOL + '://' + envs.PARSE_HOST + ':' + envs.PARSE_PORT
var mongodbURI = 'mongodb://' + envs.PARSE_MONGODB_HOST + ':' + envs.PARSE_MONGODB_PORT + '/' + envs.PARSE_MONGODB_DB
var api = new ParseServer({
  databaseURI: mongodbURI,
  appId: envs.PARSE_APP_KEY,
  masterKey: envs.PARSE_MASTER_KEY, // Keep this key secret!
  fileKey: envs.PARSE_FILE_KEY,
  serverURL: url
});

app.use('/', api);

app.listen(envs.PARSE_PORT);
