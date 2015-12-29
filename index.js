/*jslint node: true */
'use strict';

// Declare variables used
var app, base_url, bodyParser, client, express, port, rtg, shortid;
// Define values
express = require('express');
app = express();
port = process.env.PORT || 5000;
shortid = require('shortid');
bodyParser = require('body-parser');
base_url = process.env.BASE_URL || 'http://localhost:' + port;

client = require('redis').createClient();
// Set up templating
app.set('views', __dirname + '/views');
app.set('view engine', "jade");
app.engine('jade', require('jade').__express);
// Set URL
app.set('base_url', base_url);
// Handle POST data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
// Define index route
app.get('/', function (req, res) {
  res.render('index');
});
// Serve static files
app.use(express.static(__dirname + '/static'));
// Listen
app.listen(port);
console.log('Listening on port ' + port);

app.post('/', function (req, res) {
  var url, id;
  url = req.body.url;
  id = shortid.generate();
  client.set(id, url, function () {
    res.render('output', { id: id, base_url: base_url });
  });
});

app.route('/:id').all(function (req, res) {
  var id = req.params.id.trim();
  var clickId = shortid.generate();
  client.get(id, function (err, reply) {
    if (!err && reply) {
      // gather data and stats
      // here ...
      client.lpush(id + '-clicks', clickId, function(){
        client.hmset(
          id + '-' + clickId,
          { agent: req.headers['user-agent'], language: req.headers['accept-language'] });
      });
      // Redirect user to it
      res.status(302);
      res.set('Location', reply);
      res.send();
    } else {
      // Confirm no such link in database
      res.status(404);
      res.render('error');
    }
  });
});


app.route('/stats/:id').all(function (req, res) {
  var id = req.params.id.trim();
  client.get(id, function (err, reply) {
    if (!err && reply) {

      client.lrange(id + '-clicks', 0, -1, function(err, clicks){
        if (!err && reply) {
          var allClicks = clicks;
          // would be good to get all metrics from database not redis as easy query would be better performant
          res.render('stats', { id: id, clicks: allClicks });
        } else {
          res.status(404);
          res.render('error');
        }
      });
    } else {
      res.status(404);
      res.render('error');
    }
  });
});
