// modules ================================
var express = require('express');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');
var app = express();
var firebase = require("firebase");
var router = express.Router();

// configuration ==========================

// Initialize Firebase
var config = {
  apiKey: "AIzaSyDZ1pnMoLxB_OpClgKiDebKdcwP1d8Zw2A",
  authDomain: "projek-3dad4.firebaseapp.com",
  databaseURL: "https://projek-3dad4.firebaseio.com",
  projectId: "projek-3dad4",
  storageBucket: "projek-3dad4.appspot.com",
  messagingSenderId: "183887873921"
};
firebase.initializeApp(config);

// connect to db
var db = require('./config/db');
var mongoose = require('mongoose');
mongoose.connect(db.url);

var port = process.env.PORT || 3000;

// get all data/stuff of the body (POST) parameters
// parse application/json 
app.use(bodyParser.json());

// parse application/vnd.api+json as json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); 

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true })); 

// override with the X-HTTP-Method-Override header in the request. simulate DELETE/PUT
app.use(methodOverride('X-HTTP-Method-Override')); 

// routes =================================
require('./app/routes')(app);

// starting server
app.listen(port);

// shoutout to the user                     
console.log('Magic happens on port ' + port);

// expose app           
exports = module.exports = app;
