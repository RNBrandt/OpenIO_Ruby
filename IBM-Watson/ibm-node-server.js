var express  = require('express'),
  app        = express(),
  bluemix    = require('./config/bluemix'),
  watson     = require('watson-developer-cloud'),
  extend     = require('util')._extend;

// Bootstrap application settings
require('./config/express')(app);

// if bluemix credentials exists, then override local
var credentials = extend({
  version: 'v2',
  username: '<username>',
  password: '<password>'
}, bluemix.getServiceCreds('personality_insights')); // VCAP_SERVICES

// Create the service wrapper
var personalityInsights = watson.personality_insights(credentials);

// render index page
app.get('/', function(req, res) {
  res.render('index');
});

// 1. Check if we have a captcha and reset the limit
// 2. pass the request to the rate limit
app.post('/', function(req, res, next) {
  personalityInsights.profile(req.body, function(err, profile) {
    if (err)
      return next(err);
    else
      return res.json(profile);
  });
});

// error-handler settings
require('./config/error-handler')(app);

var port = process.env.VCAP_APP_PORT || 3000;
app.listen(port);
console.log('listening at:', port);