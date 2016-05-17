var express = require('express');
var ParseServer = require('parse-server').ParseServer;
var env = require('node-env-file');
var app = express();

env(__dirname + '/.env');
var envs = process.env;
var url = envs.PROTOCOL + '://' + envs.HOST + ':' + envs.PORT
var api = new ParseServer({
  databaseURI: 'mongodb://' + envs.MONGODB_HOST + ':' + envs.MONGODB_PORT + '/' + envs.MONGODB_DB,
  appId: envs.APP_KEY,
  masterKey: envs.MASTER_KEY, // Keep this key secret!
  fileKey: envs.FILE_KEY,
  serverURL: url
});

app.use('/', api);

app.listen(envs.PORT, function() {
  console.log('parse is running on ' + url);
});
